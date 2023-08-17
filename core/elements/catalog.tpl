{extends 'file:wrapper.tpl'}
{block 'content'}
    <div class="container">
        <div class="d-flex justify-content-between align-items-center py-3">
            <a href="{179 | url}">
                {'!msMiniCart' | snippet:[]}
            </a>
        </div>

        <div id="pdopage" class="py-3">
            <div class="rows py-3">
                {'!pdoPage' | snippet: [
                'parents' => 3,
                'element' => 'msProducts',
                'tpl' => '@FILE chunks/msproducts/item.tpl',
                'limit' => 5,
                'templates' => 2,
                'includeTVs' => 'modifications',
                'sortby' => ['menuindex' => 'ASC']
                ]}
            </div>
            {'page.nav' | placeholder}
        </div>
    </div>
{/block}