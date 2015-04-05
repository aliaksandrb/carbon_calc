$( ->

  scan = location.search.match(/category_id=(\d*)/)
  if scan && scan.length == 2
    category_id = scan[1] || 0
  else
    category_id = 0

  $.ajax({
    url: '/results/index',
    data: {
      category_id: category_id,
      format: 'json',
    },
    dataType: 'JSON'
  }).success((chart_data) ->
    data = {
      labels: chart_data.labels,
      datasets: [
        {
            label: chart_data.label,
            fillColor: "rgba(40, 182, 44, 0.5)",
            strokeColor: "rgba(40, 182, 44, 1)",
            pointColor: "rgba(40, 182, 44, 1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(40, 182, 44, 1)",
            data: chart_data.data
        }
      ]
    }

    options = {}

    ctx = $("#myChart").get(0).getContext("2d")
    myLineChart = new Chart(ctx).Line(data, options)
  )
)

