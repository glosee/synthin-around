$ = require 'jquery'
Mousetrap = require 'mousetrap'

class VirtualKeyboard

  defaults:
    lowestNote: 48 # Lowest note value, which is ~= 130Hz
    letters: "awsedftgyhujkolp;'".split '' # The keys users can use
    noteOn: (note) -> console.log "noteOn: #{note}"
    noteOff: (note) -> console.log "noteOff: #{note}"

  constructor: (@$el, params) ->
    @options = $.extend @defaults, params
    @keysPressed = {}
    @bindKeys()

  _noteOn: (note) ->
    return if note of @keysPressed
    $(@$el.find('li').get(note - @options.lowestNote)).addClass 'active'
    @keysPressed[note] = yes
    @options.noteOn note

  _noteOff: (note) ->
    return unless note of @keysPressed
    $(@$el.find('li').get(note - @options.lowestNote)).removeClass 'active'
    delete @keysPressed[note]
    @options.noteOff note

  bindKeys: ->
    for letter, i in @options.letters
      do (letter, i) =>
        Mousetrap.bind letter, (=>
          @_noteOn(@options.lowestNote + i)
        ), 'keydown'
        Mousetrap.bind letter, (=>
          @_noteOff(@options.lowestNote + i)
        ), 'keyup'

    Mousetrap.bind 'z', =>
      @options.lowestNote -= 12 # Shift down one octave

    Mousetrap.bind 'x', =>
      @options.lowestNote += 12 # Shift up one octave



module.exports = VirtualKeyboard
