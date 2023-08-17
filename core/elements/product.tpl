{extends 'file:wrapper.tpl'}
{block 'content'}
    <div class="container">
        <div class="d-flex justify-content-between align-items-center py-3">
            <a href="{179 | url}">
                {'!msMiniCart' | snippet:[]}
            </a>
            <a href="{1 | url}">
                На главную
            </a>
        </div>
        <div class="py-3">
            {include 'msProduct.content.fenom'}
        </div>
    </div>
{/block}