#= require jquery
#= require jquery_ujs
#= require_tree .

$ ->

  $('#toggle-filter').on 'click', ->
    $('.filters').css('left', $(this).position().left + 'px').toggle()

  $('.left-side, .right-side').mouseup (e) ->
    container = $('.filters')
    if !(container.is(e.target)) && (container.has(e.target).length is 0)
      container.hide()
