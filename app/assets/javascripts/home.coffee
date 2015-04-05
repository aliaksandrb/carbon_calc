$( ->

  chart_container = $('.chart-container')
  if chart_container.size() > 0
    scan = location.search.match(/category_id=(\d*)/)

    # https://css-tricks.com/snippets/javascript/lighten-darken-color/
    colorTone = (col, amt) ->
      usePound = false

      if col[0] == "#"
        col = col.slice(1)
        usePound = true

      num = parseInt(col, 16)
      r = (num >> 16) + amt

      if r > 255
        r = 255
      else if r < 0
        r = 0

      b = ((num >> 8) & 0x00FF) + amt

      if b > 255
        b = 255
      else if b < 0
        b = 0

      g = (num & 0x0000FF) + amt

      if g > 255
        g = 255
      else if g < 0
        g = 0

      str = if usePound then '#' else ''
      return str + (g | (b << 8) | (r << 16)).toString(16)

    randomColor = ->
      return '#' + Math.random().toString(16).slice(2, 8)

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
      if chart_data.data.length > 0
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

        options = {
          responsive: true,
          scaleLineColor: '#777777',
          scaleFontColor: '#777777'
        }

        container_for_chart = $(
          '<canvas height="300" id="chart-general" width="' +
          chart_container.width() + '"></canvas>'
        )

        ctx = container_for_chart.get(0).getContext("2d")
        chart_container.append([
          '<h4>CHART FOR: ' + chart_data.label.toUpperCase() + '</h4>'
          container_for_chart
        ])
        myLineChart = new Chart(ctx).Line(data, options)
      else
        chart_container.empty()
    )

    $.ajax({
      url: '/results/insides',
      data: {
        format: 'json',
      },
      dataType: 'JSON'
    }).success((chart_data) ->
      chart_container_right = $('.chart-insides-right')

      if chart_data.length > 0
        data_right = []

        $.each(chart_data, (index, value) ->
          color = randomColor()

          data_right.push({
            value: value.value,
            color: color,
            highlight: colorTone(color, 20),
            label: value.label
          })
        )

        options = {
          legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend list-unstyled \"><% for (var i=0; i<segments.length; i++){%><li><span class=\"glyphicon glyphicon-tree-deciduous\" aria-hidden=\"true\" style=\"background-color:<%=segments[i].fillColor%>;color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
        }

        container_for_chart = $('<canvas height="300" id="chart-insides-right" width="' +
          chart_container_right.width() + '"></canvas>'
        )

        ctx = container_for_chart.get(0).getContext("2d")
        chart_container_right.append(container_for_chart)
        myPieChart = new Chart(ctx).Pie(data_right, options)
        chart_container_right.append(myPieChart.generateLegend())
      else
        chart_container_right.empty()
    )

    $.ajax({
      url: '/results/insides_historical',
      data: {
        format: 'json',
      },
      dataType: 'JSON'
    }).success((chart_data) ->
      chart_container_left = $('.chart-insides-left')

      if chart_data.labels.length > 0
        data_left = {
          labels: chart_data.labels,
        }

        datasets = []

        $.each(chart_data.datasets, (index, value) ->
          color = randomColor()

          datasets.push({
            label: value.label,
            fillColor: color,
            strokeColor: colorTone(color, -40),
            highlightFill: colorTone(color, 20),
            highlightStroke: colorTone(color, -20),
            data: value.data
          })
        )

        data_left.datasets = datasets
        options = {
            legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend list-unstyled\"><% for (var i=0; i<datasets.length; i++){%><li><span class=\"glyphicon glyphicon-tree-deciduous\" aria-hidden=\"true\" style=\"background-color:<%=datasets[i].fillColor%>;color:<%=datasets[i].fillColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>"
        }

        container_for_chart = $('<canvas height="300" id="chart-insides-left" width="' +
          chart_container_left.width() + '"></canvas>'
        )

        ctx = container_for_chart.get(0).getContext("2d")
        chart_container_left.append(container_for_chart)
        myBarChart = new Chart(ctx).Bar(data_left, options)
        chart_container_left.append(myBarChart.generateLegend())
      else
        chart_container_left.empty()
    )
)

