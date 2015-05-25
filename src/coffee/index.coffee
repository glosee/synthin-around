$ = window.jQuery = window.$ = require 'jquery'
Scissor = require './scissor.coffee'
VirtualKeyboard = require './virtual-keyboard.coffee'
{NODE_TYPES} = require './utils.coffee'

$ ->

  audioContext = new (AudioContext ? webkitAudioContext)
  masterGain = window.masterGain = audioContext.createGain()
  masterGain.gain.value = 0.7
  masterGain.connect audioContext.destination

  scissor = window.scissor = new Scissor(audioContext)
  scissor.connect audioContext.destination

  # testing...
  # scissor.noteOn 60
  # scissor.noteOn 64
  # scissor.noteOn 68

  keyboardManager = new VirtualKeyboard $('#keys'),
    noteOn: (note) ->
      scissor.noteOn note
    noteOff: (note) ->
      scissor.noteOff note

  # Setup node selector
  $nodeSelector = $ '#select-node-type'
  for nodeType in NODE_TYPES
    $option = $ "<option value=#{nodeType}>#{nodeType}</option>"
    $nodeSelector.append $option
  $nodeSelector.on 'change', (e) ->
    scissor.updateNodeType $(e.target).val()
    $nodeSelector.blur()
