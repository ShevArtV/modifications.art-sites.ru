<div class="ms2_product mb-5 mb-md-3" itemtype="http://schema.org/Product" itemscope>
    <meta itemprop="description" content="{$description = $description ?: $pagetitle}">
    <meta itemprop="name" content="{$pagetitle}">

    <form method="post" class="ms2_form d-flex flex-column flex-md-row align-items-center no-gutters" data-msproduct>
        <input type="hidden" name="id" data-msfield="id" value="{$id}">
        <input type="hidden" name="count" value="1">
        <input type="hidden" name="options" value="[]">
        <div class="col-md-2 text-center text-md-left">
            <a href="{$id | url}">
                {if $thumb?}
                    <img src="{$thumb}" class="mw-100" alt="{$pagetitle}" title="{$pagetitle}" data-msfield="img" itemprop="image"/>
                {else}
                    <img src="{'assets_url' | option}components/minishop2/img/web/ms2_small.png"
                         srcset="{'assets_url' | option}components/minishop2/img/web/ms2_small@2x.png 2x"
                         class="mw-100" alt="{$pagetitle}" title="{$pagetitle}"/>
                {/if}
            </a>
        </div>
        <div class="col-md-10 d-flex flex-column flex-md-row align-items-center no-gutters" itemtype="http://schema.org/AggregateOffer" itemprop="offers" itemscope>
            <meta itemprop="category" content="{$parent | resource: "pagetitle"}">
            <meta itemprop="name" content="{$pagetitle}">
            <meta itemprop="offerCount" content="1">
            <meta itemprop="price" content="{$price | replace:" ":""}">
            <meta itemprop="lowPrice" content="{$price | replace:" ":""}">
            <meta itemprop="priceCurrency" content="RUR">

            <div class="col-12 col-md-8 mt-2 mt-md-0 flex-grow-1">
                <div class="d-flex justify-content-around justify-content-md-start">
                    <a href="{$id | url}" class="font-weight-bold"><span data-msfield="pagetitle">{$pagetitle}</span></a>
                    <span class="price ml-md-3"><span data-msfield="price">{$price}</span> {'ms2_frontend_currency' | lexicon}</span>
                    {if $old_price?}
                        <span class="old_price ml-md-3"><span data-msfield="old_price">{$old_price}</span> {'ms2_frontend_currency' | lexicon}</span>
                    {/if}
                </div>
                <div class="flags mt-2 d-flex justify-content-around justify-content-md-start">
                    {if $new?}
                        <span class="badge badge-secondary badge-pill mr-md-1">{'ms2_frontend_new' | lexicon}</span>
                    {/if}
                    {if $popular?}
                        <span class="badge badge-secondary badge-pill mr-md-1">{'ms2_frontend_popular' | lexicon}</span>
                    {/if}
                    {if $favorite?}
                        <span class="badge badge-secondary badge-pill mr-md-1">{'ms2_frontend_favorite' | lexicon}</span>
                    {/if}
                </div>
                {if $introtext}
                    <div class="mt-2 text-center text-md-left">
                        <small>{$introtext | truncate : 200}</small>
                    </div>
                {/if}

                {foreach $modifications as $k => $m}
                    <div class="form-group row align-items-center">
                        <label class="col-6 col-md-3 text-right text-md-left col-form-label" for="option_{$k}">ms2_product_{$k}:</label>
                        <div class="col-6 col-md-9">
                            <select name="options[{$k}]" class="form-control col-md-6" data-modoptions="{$k === 'age' ? 'master':'slave'}" id="option_{$k}">
                                {foreach $m as $v => $ids}
                                <option value="{$v}" data-ids="{$ids | join: ','}">{$v}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                {/foreach}
            </div>
            <div class="col-12 col-md-4 mt-2 mt-md-0 text-center text-md-right">
                <button class="btn btn-primary" type="submit" name="ms2_action" value="cart/add">
                    {'ms2_frontend_add_to_cart' | lexicon}
                </button>
            </div>
        </div>
    </form>
</div>
