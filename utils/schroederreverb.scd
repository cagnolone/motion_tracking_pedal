(
Ndef(\verb, {
	var input, output, delrd, sig, deltimes, modtime;

	// Choose which sort of input you want by (un)commenting these lines:
	//input = Pan2.ar(PlayBuf.ar(1, b, loop: 0), -0.5); // buffer playback, panned halfway left
	input = SoundIn.ar([0,1]); // TAKE CARE of feedback - use headphones
	//input = Dust2.ar([0.1, 0.01]); // Occasional clicks

	// Read our 4-channel delayed signals back from the feedback loop
	delrd = LocalIn.ar(4);

	// This will be our eventual output, which will also be recirculated
	output = input + delrd[[0,1]];

	sig = output ++ delrd[[2,3]];
	// Cross-fertilise the four delay lines with each other:
	sig = ([ [1, 1, 1, 1],
	 [1, -1, 1, -1],
	 [1, 1, -1, -1],
	 [1, -1, -1, 1]] * sig).sum;
	// Attenutate the delayed signals so they decay:
	sig = sig * [0.4, 0.37, 0.333, 0.3];

	// Here we give delay times in milliseconds, convert to seconds,
	// then compensate with ControlDur for the one-block delay
	// which is always introduced when using the LocalIn/Out fdbk loop
	modtime = MouseX.kr(0.001, 0.005);
	deltimes = [101, 143, 165, 177] * modtime - ControlDur.ir;

	// Apply the delays and send the signals into the feedback loop
	LocalOut.ar(DelayC.ar(sig, deltimes, deltimes));

	// Now let's hear it:
	output

}).play
)

(
SynthDef(\verb1, {
	arg modtime1=0.001;
	var input, output, delrd, sig, deltimes, modtime;

	// Choose which sort of input you want by (un)commenting these lines:
	//input = Pan2.ar(PlayBuf.ar(1, b, loop: 0), -0.5); // buffer playback, panned halfway left
	input = SoundIn.ar([0,1]); // TAKE CARE of feedback - use headphones
	//input = Dust2.ar([0.1, 0.01]); // Occasional clicks

	// Read our 4-channel delayed signals back from the feedback loop
	delrd = LocalIn.ar(4);

	// This will be our eventual output, which will also be recirculated
	output = input + delrd[[0,1]];

	sig = output ++ delrd[[2,3]];
	// Cross-fertilise the four delay lines with each other:
	sig = ([ [1, 1, 1, 1],
	 [1, -1, 1, -1],
	 [1, 1, -1, -1],
	 [1, -1, -1, 1]] * sig).sum;
	// Attenutate the delayed signals so they decay:
	sig = sig * [0.4, 0.37, 0.333, 0.3];

	// Here we give delay times in milliseconds, convert to seconds,
	// then compensate with ControlDur for the one-block delay
	// which is always introduced when using the LocalIn/Out fdbk loop
	//modtime = MouseX.kr(0.001, 0.005);
	deltimes = [101, 143, 165, 177] * modtime1 - ControlDur.ir;

	// Apply the delays and send the signals into the feedback loop
	LocalOut.ar(DelayC.ar(sig, deltimes, deltimes));

	// Now let's hear it:
	Out.ar([0,1], output);


}).add
)


s = Synth(\verb1);


NetAddr("10.79.9.191",57120);



(
var synth1;
synth1 = Synth(\verb1);

p = 0;

OSCdef('OSCreceiver',
	{
		arg msg;
		var max = 0.002;
		//msg.postln;
		x = msg[1];
		x = x.abs;
		s = LinLin.kr(x, 0, 80, 0.001, max);
		s = round(s, 0.000001);

		//for ( p*100000, s, 0.0000001, {arg i; synth1.set(\modtime1,i);  } );

		if(s<0){
		s=0;
		};
		if(s>max){
		s=max;
		};
		s.postln;
		synth1.set(\modtime1,s);
		p = s;

	},
	"/orientation/pitch");
)