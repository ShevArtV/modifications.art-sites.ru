{extends 'file:wrapper.tpl'}
{block 'content'}
    <div class="container">
        <div class="d-flex justify-content-between align-items-center py-3">
            <a href="{1 | url}">
                На главную
            </a>
        </div>
        <div class="py-3">
            {'!msCart' | snippet:[]}
            {'!msOrder' | snippet:[]}
            {'!msGetOrder' | snippet:[]}
        </div>
    </div>
{/block}