function showChart(){
  var fatCals = $('#chart').data('fat-cals');
  var proteinCals = $('#chart').data('protein-cals');
  var carbsCals = $('#chart').data('carbs-cals');
  var ctx = document.getElementById('macrosChart').getContext('2d');
  var macrosChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
      datasets: [{
        data: [fatCals, proteinCals, carbsCals],
        backgroundColor: [
          '#FCEA85',
          '#FFA274',
          '#2CC3A1'
        ],
      }],
      labels: ['Fat', 'Protein', 'Carbohydrates'],
    },
    options: {
      responsive: true,
      legend: {
        position: 'bottom',
      },
      title: {
        display: true,
        text: 'Percent Calories from Macronutrients',
        fontSize: 14,
        onHover: function(event, title) {
          alert('Success');
        },
      },
      tooltips: {
        enabled: true,
        callbacks: {
          label: function(tooltipItem, data) {
            return Math.round(
              data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]
            ) + '%';
          }
        }
      }
    }
  });
}

$(document).on('turbolinks:load', function() {
  showChart();
});
