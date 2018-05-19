

(

SynthDef(\pitchshiftgranular, {
     // first input
    // delay output to tame feedback in case of microphones are configured:
	var grainSize = 0.5;
	var effect = PitchShift.ar(

		SoundIn.ar(),

		grainSize,

		1,						// nominal pitch rate = 1

		MouseX.kr(0,1), 			// pitch dispersion

		MouseY.kr(0, grainSize)	// time dispersion

	);
    Out.ar(0, effect + SoundIn.ar*0.4);
	Out.ar(1, effect + SoundIn.ar*0.4);
}).play
)