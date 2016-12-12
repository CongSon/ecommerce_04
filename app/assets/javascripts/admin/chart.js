var chart = {
  options: {
    title: {
      text: I18n.t("weekly_report")
    },
    xAxis: {
      categories: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    },
    yAxis: {
      min: 0,
      allowDecimals: false,
      title: {
        text: I18n.t("number")
      }
    },
    tooltip: {
      shared: true
    },
    legend: {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'middle',
      borderWidth: 0
    },
    series: []
  },

  initialize: function() {
    $.getJSON('/admin/charts.json', function(data) {
      chart.options.series = [];
      $.each(data, function(i, json_data) {
        chart.options.series.push({
          name: json_data.name,
          type: json_data.type,
          data: json_data.data,
          tooltip: json_data.tooltip
        });
      });
      chart.draw_chart();
    });
  },
  draw_chart: function() {
    Highcharts.chart('chart-report', chart.options);
  }
}
