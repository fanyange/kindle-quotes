jQuery ->
  Morris.Line
    element: 'frequency'
    data: $('#frequency').data('freq')
    xkey: 'date'
    ykeys: ['sum_count']
    labels: ['Count']
    hoverCallback: (index, options, content, row) ->
      f = row.favorite.split(/[(:]/)[0]
      f = f.substring(0,5) + "..." if f.length > 5
      r = "<div class='morris-hover-point' style='color: #DB7473'>Favorite: #{f}</div>"
      content + r
