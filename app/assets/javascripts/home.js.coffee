# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).keypress (event) -> 
    unless $(event.target).is("input")
      switch event.charCode
        when 86, 117
          $('a#upload-link')[0].click()
        when 72, 104
          $('a#home-link')[0].click()
        when 73, 105
          $('a#images-link')[0].click()
        when 84, 116
          $('a#tags-link')[0].click()
      
