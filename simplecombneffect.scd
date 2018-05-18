s.options.device_("ASIO : Focusrite USB ASIO");

(

SynthDef(\helpAudioIn, { |out|
     // first input
    // delay output to tame feedback in case of microphones are configured:
    Out.ar(0, CombN.ar(SoundIn.ar * 0.9, 0.2, 0.2, 0.001));
	Out.ar(1, SoundIn.ar * 0.5);
}).play
)