{*
* 2007-2017 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2017 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{block name='order_slip'}
	{capture name=path}<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">{l s='My account'}</a><span class="navigation-pipe">{$navigationPipe}</span><span class="navigation_page">{l s='Credit slips'}</span>{/capture}

	<h1 class="page-heading bottom-indent">
		{l s='Credit slips'}
	</h1>
	<p class="info-title">
		{l s='Credit slips you have received after canceled orders'}.
	</p>

	{block name='errors'}
		{include file="$tpl_dir./errors.tpl"}
	{/block}

	{if isset($smarty.get.confirmation) && $smarty.get.confirmation}
		<p class="alert alert-success">
			{l s='Your voucher has been generated successfully and sent via email.'} <a href="{$link->getPageLink('discount', true)|escape:'html':'UTF-8'}">{'Click here'}</a> {' to see your all vouchers.'}
		</p>
	{/if}

	{block name='order_slip_list'}
		<div class="block-center" id="block-history">
			{if $ordersSlip && count($ordersSlip)}
				<table id="order-list" class="table table-bordered footab">
					<thead>
						<tr>
							<th data-sort-ignore="true" class="first_item">{l s='Credit slip'}</th>
							<th data-sort-ignore="true" class="item">{l s='Order'}</th>
							<th class="item">{l s='Date issued'}</th>
							<th data-sort-ignore="true" data-hide="phone">{l s='View credit slip'}</th>
							<th data-sort-ignore="true">{l s='Status'}</th>
							<th data-sort-ignore="true" data-hide="phone" class="last_item">{l s='Actions'}</th>
						</tr>
					</thead>
					<tbody>
						{foreach from=$ordersSlip item=slip name=myLoop}
							<tr class="{if $smarty.foreach.myLoop.first}first_item{elseif $smarty.foreach.myLoop.last}last_item{else}item{/if} {if $smarty.foreach.myLoop.index % 2}alternate_item{/if}">
								<td class="bold">
									<span class="color-myaccount">
										#{Configuration::get('PS_CREDIT_SLIP_PREFIX', $lang_id)}{$slip.id_order_slip|string_format:"%06d"}
									</span>
								</td>
								<td class="history_method">
									<a class="color-myaccount" href="{$link->getPageLink('order-detail', true, NULL, "id_order={$slip.id_order|intval}")|escape:'html':'UTF-8'}" target="_blank">
										#{$slip.id_order|string_format:"%06d"}
									</a>
								</td>
								<td class="bold"  data-value="{$slip.date_add|regex_replace:"/[\-\:\ ]/":""}">
									{dateFormat date=$slip.date_add full=0}
								</td>
								<td class="history_invoice">
									<a class="link-button" href="{$link->getPageLink('pdf-order-slip', true, NULL, "id_order_slip={$slip.id_order_slip|intval}")|escape:'html':'UTF-8'}" title="{l s='Credit slip'} #{Configuration::get('PS_CREDIT_SLIP_PREFIX', $lang_id)}{$slip.id_order_slip|string_format:"%06d"}">
										<i class="icon-file-text large"></i>{l s='PDF'}
									</a>
								</td>
								<td>
									{if $slip.redeem_status == OrderSlip::REDEEM_STATUS_REDEEMED}
										<span class="badge badge-danger">{l s='Redeemed'}</span>
									{else}
										<span class="badge badge-success">{l s='Active'}</span>
									{/if}
								</td>
								<td>
									{if $slip.redeem_status == OrderSlip::REDEEM_STATUS_ACTIVE && !$slip.id_cart_rule}
										<a href="{$link->getPageLink('order-slip', true, NULL, "generateVoucher=1&id_order_slip={$slip.id_order_slip|intval}")|escape:'html':'UTF-8'}" title="{l s='Generate voucher for credit slip '} #{Configuration::get('PS_CREDIT_SLIP_PREFIX', $lang_id)}{$slip.id_order_slip|string_format:"%06d"}">
											<u>{l s='Generate Voucher'}</u>
										</a>
									{elseif $slip.redeem_status == OrderSlip::REDEEM_STATUS_REDEEMED && $slip.id_cart_rule}
										<span class="badge badge-danger">{l s='Voucher Generated'}</span>
									{elseif $slip.redeem_status == OrderSlip::REDEEM_STATUS_REDEEMED && !$slip.id_cart_rule}
										--
									{/if}
								</td>
							</tr>
						{/foreach}
					</tbody>
				</table>
				<div id="block-order-detail" class="unvisible">&nbsp;</div>
			{else}
				<p class="alert alert-warning">{l s='You have not received any credit slips.'}</p>
			{/if}
		</div><!-- #block-history -->
	{/block}
	{block name='order_slip_footer_links'}
		<ul class="footer_links clearfix">
			<li>
				<a class="btn btn-default button button-small" href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">
					<span>
						<i class="icon-chevron-left"></i> {l s='Back to My account'}
					</span>
				</a>
			</li>
			<li>
				<a class="btn btn-default button button-small" href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}">
					<span>
						<i class="icon-chevron-left"></i> {l s='Home'}
					</span>
				</a>
			</li>
		</ul>
	{/block}
{/block}
