# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#load_from_url input').change ->
    $("#file-upload").toggle()
    $("#url-upload").toggle()
  
  $('#image').change ->
    split = $('#image').val().split('\\')
    fileName = split[split.length-1]
    fileName = fileName.replace(/\.[^/.]+$/, '')
    $('#name').val(fileName)
    return null

  $('#url-upload').change ->
    # this could get really ugly 
    # only update the field if it is blank
    # removing a name for a filename hint is 
    # not very enjoyable
    field = $('#name')
    if field.val() == ""
        split = $('#url_field').val().split('/')
        fileName = split[split.length - 1]
        fileName = fileName.replace(/\.[^/.]+$/, '')
        field.val(fileName)
