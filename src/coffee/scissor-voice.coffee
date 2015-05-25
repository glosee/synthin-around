{NODE_TYPES} = require './utils.coffee'

class ScissorVoice

  constructor: (@context, @frequency, @numSaws, @detune, @nodeType='sawtooth') ->
    @output = @context.createGain()
    @maxGain = 1 / @numSaws
    @saws = []
    for i in [0...@numSaws]
      saw = @context.createOscillator()
      saw.type = @nodeType
      saw.frequency.value = @frequency
      saw.detune.value = -@detune + i * 2 * @detune / (@numSaws - 1)
      saw.start @context.currentTime
      saw.connect @output
      @saws.push saw

  start: (time) ->
    @output.gain.setValueAtTime @maxGain, time

  stop: (time) ->
    @output.gain.setValueAtTime 0, time
    setTimeout (=>
      @saws.forEach (saw) ->
        saw.disconnect()
    ), Math.floor((time - @context.currentTime) * 1000)

  connect: (target) ->
    @output.connect target


module.exports = ScissorVoice
