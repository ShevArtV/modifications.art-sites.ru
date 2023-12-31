class Modoptions {
    constructor(root) {
        this.root = root;
        this.config = {
            modOptions: root.querySelectorAll('[data-modoptions]'),
            masterOption: root.querySelector('[data-modoptions="master"]'),
            slaveOptions: root.querySelectorAll('[data-modoptions="slave"]'),
            actionUrl: 'assets/action.php',
            btns: root.querySelectorAll('[name="ms2_action"]'),
        };
        this.modId = 0;
        this.toggleEvent = new CustomEvent('mo:toggle_complete', {
            bubbles: true,
            detail: {
                root: root,
                config: this.config,
                modId: this.modId
            }
        });
        this.modNotFoundEvent = new CustomEvent('mo:not_found', {
            bubbles: true,
            detail: {
                root: root,
                config: this.config,
                modId: this.modId
            }
        });
        this.initialize();
    }
    getCookie(name) {
        let matches = document.cookie.match(new RegExp(
            "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
        ));
        return matches ? decodeURIComponent(matches[1]) : undefined;
    }
    initialize() {
        if (!this.config.modOptions.length) return false;
        document.addEventListener('mo:toggle_complete', (e) => this.send(e));

        document.addEventListener('change', (e) => {
            const selectOption = e.target.closest('[data-modoptions]');
            if (selectOption) {
                this.toggleDisabled();
                this.setModId();
            }
        });

        this.toggleDisabled();
        this.setModId();
    }

    async send(e) {
        if (!this.modId) {
            this.config.btns?.forEach(btn => btn.disabled = true);
            document.dispatchEvent(this.modNotFoundEvent);
            this.error({msg: 'Такой модификации не существует!'});
            return false;
        }
        this.config.btns?.forEach(btn => btn.disabled = false);
        const params = new FormData();
        params.append('id', this.modId);
        const response = await fetch(this.config.actionUrl, {
            method: 'POST',
            body: params,
            headers: {
                'X-MSMODS': 'get/modification',
                'X-MSTOKEN': this.getCookie('msmods')
            }
        });

        const result = await response.json();
        if (result.id) {
            this.success(result)
        } else {
            this.error(result)
        }
    }

    success(result) {
        for (let k in result) {
            const block = this.root.querySelector(`[data-msfield="${k}"]`);
            if (!block) continue;
            switch (block.tagName) {
                case 'INPUT':
                    block.value = result[k];
                    break;
                case 'IMG':
                    block.src = result[k];
                    break;
                default:
                    block.textContent = result[k];
                    break;
            }
        }
    }

    error(result) {
        if(typeof miniShop2 !== 'undefined' && result.msg){
            miniShop2.Message.error(result.msg);
        }
    }

    toggleDisabled(){
        if(!this.config.masterOption || !this.config.slaveOptions.length) return;
        const ids = this.config.masterOption.options[this.config.masterOption.selectedIndex].dataset.ids.split(',');
        if(this.config.slaveOptions.length){
            this.config.slaveOptions.forEach((select) => {
                const options = select.options;
                for (let k in options) {
                    if (typeof options[k] !== 'object') continue;
                    const currentIds = options[k].dataset.ids.split(',');
                    const intersect = currentIds?.filter(x => ids?.includes(x));
                    if(intersect.length){
                        options[k].disabled = false;
                    }else{
                        options[k].disabled = true;
                        options[k].selected = false;
                    }

                }

                if(select.selectedIndex === -1){
                    const option = select.querySelector('option:not(:disabled)');
                    option.selected = true;
                }
            });
        }
    }

    setModId() {
        const modOptions = this.root.querySelectorAll('[data-modoptions] option:checked');
        let intersections = [];
        if (modOptions.length) {
            modOptions.forEach((option, i) => {
                const ids = option.dataset.ids.split(',');
                if (!intersections.length && i === 0) {
                    intersections = ids;
                } else {
                    intersections = ids?.filter(x => intersections?.includes(x));
                }
            });

            intersections.length === 1 ? this.modId = intersections[0] : this.modId = 0;
        }
        document.dispatchEvent(this.toggleEvent);
    }
}

document.addEventListener('DOMContentLoaded', (e) => {
    const ms2Forms = document.querySelectorAll('[data-msproduct]');
    if (ms2Forms.length) {
        ms2Forms.forEach(root => new Modoptions(root));
    }
});