

s.options.device_("ASIO : Focusrite USB ASIO");

(

SynthDef(\helpAudioIn, {
     // first input
    // delay output to tame feedback in case of microphones are configured:
	var effect= DelayN.ar(SoundIn.ar , 10 , MouseX.kr);
    Out.ar(0, effect + SoundIn.ar*0.4);
	Out.ar(1, effect + SoundIn.ar*0.4);
}).play
)