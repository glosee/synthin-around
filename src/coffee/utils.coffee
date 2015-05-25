# The magic math equation that turns a note signal into a frequency that the
# WebAudioAPI can understand and process.
noteToFrequency = (note) ->
  Math.pow(2, (note - 69) / 12) * 440.0

NODE_TYPES = [
  'sine'
  'square'
  'sawtooth'
  'triangle'
  'custom'
]

module.exports = {noteToFrequency, NODE_TYPES}
