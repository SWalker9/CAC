/*  jQuery.print, version 1.0.3
 *  (c) Sathvik Ponangi, Doers' Guild
 * Licence: CC-By (http://creativecommons.org/licenses/by/3.0/)
 *--------------------------------------------------------------------------*/
 $('#search-box').dialog({
	autoOpen: false,
	resizable: false,
	height: 560,
	width: 700,
	modal: true,
	buttons: {
		Cancel: function () {
			$(this).dialog("close");
		}
	}
});
    
$('#search-form').submit(function (event) {
	$.post('/umbraco/Surface/Search/LookFor', { terms: $('input:first', $(this)).val() }, function (data) {

		var resultList = $('#search-result-list');
		resultList.empty();
		var urlPrefix = location.hostname + (location.port != 80 ? (':' + location.port) : '');

		$.each(data, function (index) {
			var item = $('<li></li>', { 'class': 'search-item-result', id: data[index].Id });
			var score = $('<span title="search score">' + data[index].Score + '%</span>');
			item.append(score);

			var result = $('<a href="' + data[index].Url + '"><p>' + data[index].Text + '&hellip;</p></a>');
			var link = $('<a></a>', { text: urlPrefix + '/' + data[index].Url, href: data[index].Url, 'class': 'search-result-link' });

			item.append(result);
			item.append(link);
			resultList.append(item);
		});

		$("#search-box").dialog('open');
	});
	event.preventDefault();
});    

public class SearchController : SurfaceController
{

	public JsonResult LookFor(string terms)
	{
		if (!string.IsNullOrEmpty(terms))
		{
			var criteria = ExamineManager.Instance
				.SearchProviderCollection["ExternalSearcher"]
				.CreateSearchCriteria();

			// Find pages that contain our search text in either their nodeName or bodyText fields...
			// but exclude any pages that have been hidden.
			// searchCriteria.Fields("nodeName",terms.Boost(8)).Or().Field("metaTitle","hello".Boost(5)).Compile();

			var crawl = criteria.GroupedOr(new string[] { "bodyText", "nodeName" }, terms)
				.Not()
				.Field("umbracoNaviHide", "1")
				.Not()
				.Field("nodeTypeAlias", "Image")
				.Compile();

			ISearchResults SearchResults = ExamineManager.Instance
				.SearchProviderCollection["ExternalSearcher"]
				.Search(crawl);

			IList<Result> results = new List<Result>();

			foreach (SearchResult sr in SearchResults)
			{
				Result result = new Result()
				{
					Id = sr.Id,
					Score = (int)Math.Min(sr.Score * 100, 100),
					Url = sr.Fields["urlName"],
					Text = sr.Fields["bodyText"]
				};

				result.Text = result.Text.Substring(0, Math.Min(result.Text.Length, 200));
				results.Add(result);
			}

			return Json(results, JsonRequestBehavior.AllowGet);

		}
		else
		{
			return Json("Search term not found", JsonRequestBehavior.AllowGet);
		}

	}

}
(jQuery);