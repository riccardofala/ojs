{**
 * templates/frontend/objects/galley_link.tpl
 *
 * Copyright (c) 2018
 * Distributed under the GNU GPL v3.
 *
 *}

{* Override the $currentJournal context if desired *}
{if $journalOverride}
    {assign var="currentJournal" value=$journalOverride}
{/if}

{* Determine galley type and URL op *}
{if $galley->isPdfGalley()}
    {assign var="type" value="pdf"}
{else}

{/if}

{* Get page and parentId for URL *}
{if $parent instanceOf Issue}
    {assign var="page" value="issue"}
    {assign var="parentId" value=$parent->getBestIssueId()}
{else}
    {assign var="page" value="article"}
    {assign var="parentId" value=$parent->getBestArticleId()}
{/if}

{* Get user access flag *}
{if !$hasAccess}
    {if $restrictOnlyPdf && $type=="pdf"}
        {assign var=restricted value="1"}
    {elseif !$restrictOnlyPdf}
        {assign var=restricted value="1"}
    {/if}
{/if}

{* Don't be frightened. This is just a link *}
<span class="galley-icon-wrapper">
<a target="_blank" style="padding: 25px;" class="galley-icon galley-link {if $isSupplementary}obj_galley_link_supplementary{else}obj_galley_link{/if} {$type}{if $restricted} restricted{/if}"
   href="{url page=$page op="download" path=$parentId|to_array:$galley->getBestGalleyId() params=['inline' => 1] }">

    {* Add some screen reader text to indicate if a galley is restricted *}
    {if $restricted}
        <span class="sr-only">
			{if $purchaseArticleEnabled}
                {translate key="reader.subscriptionOrFeeAccess"}
            {else}
                {translate key="reader.subscriptionAccess"}
            {/if}
		</span>
    {/if}

    {$galley->getLabel()}

    {if $restricted && $purchaseFee && $purchaseCurrency}
        <span class="purchase_cost">
			{translate key="reader.purchasePrice" price=$purchaseFee currency=$purchaseCurrency}
		</span>
    {/if}
</a>
</span>