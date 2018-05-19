

// pitch shift input - USE HEADPHONES to prevent feedback.


(

SynthDef(\pitchshift, {
     // first input
    // delay output to tame feedback in case of microphones are configured:
	arg pitch = 0;
	var effect = PitchShift.ar(

		SoundIn.ar(),	// stereo audio input

		0.1, 			// grain size

		pitch,	// mouse x controls pitch shift ratio

		0, 				// pitch dispersion

		0.004			// time dispersion

	);
    Out.ar(0, effect + SoundIn.ar*0.2);
	Out.ar(1, effect + SoundIn.ar*0.2);
}).add
)

s = Synth(\pitchshift);


NetAddr("10.79.9.191",57500);



(
var synth1;
synth1 = Synth(\pitchshift);


OSCdef('OSCreceiver',
	{
		arg msg;
		msg.postln;
		x = msg[2];
		x.postln;


		if(x<0){
		x=0;
		};
		if(x>4){
		x=4;
		};

		synth1.set(\pitch,x);

	},
	"/mobile1/magnetic");
)