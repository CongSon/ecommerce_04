var lineChart = {
  options: {
    chart: {
      plotBackgroundColor: null,
      plotBorderWidth: null,
      plotShadow: false,
    },
    title: {
      text: I18n.t("revenue_weekly_report")
    },
    xAxis: {
      categories: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    },
    yAxis: {
      min: 0,
      allowDecimals: false,
      title: {
        text: I18n.t("total_pay")
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
     $.getJSON('/admin/line_chart.json', function(data) {
       lineChart.options.series = []
       $.each(data, function(i, json_data) {
         lineChart.options.series.push({
           name: json_data.name,
           colorByPoint: json_data.colorByPoint,
           data: json_data.data
         });
       });
       lineChart.draw_chart();
     });
   },

   draw_chart: function() {
     Highcharts.chart('line-chart-report', lineChart.options);
   }
 };
