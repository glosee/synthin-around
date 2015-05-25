ScissorVoice = require './scissor-voice.coffee'
{noteToFrequency} = require './utils.coffee'

# A high-level synth object that controls the notes played by the user
# Requires an AudioContext
class Scissor

  constructor: (@context, @nodeType='sine') ->
    # Set default values
    console.log @context
    console.log @context.createGain()
    @numSaws = 3
    @detune = 12
    @voices = []
    @output =  @context.createGain()

  noteOn: (note, time) ->
    # Don't press this note again if it's already playing
    return this if @voices[note]?
    time ?= @context.currentTime
    freq = noteToFrequency note
    voice = new ScissorVoice @context, freq, @numSaws, @detune, @nodeType
    voice.connect @output
    voice.start time
    @voices[note] = voice
    this

  noteOff: (note, time) ->
    return this unless @voices[note]?
    time ?= @context.currentTime
    @voices[note].stop time
    delete @voices[note]
    this

  connect: (target) ->
    @output.connect target

  updateNodeType: (nodeType) ->
    console.log 'update node type', nodeType
    @nodeType = nodeType


module.exports = Scissor
