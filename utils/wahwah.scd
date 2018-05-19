(
SynthDef(\wah, { arg rate = 1.5, cfreq = 1400, mfreq = 1200, rq=0.1, freq = 440;

	var zin, zout;
	zin = SoundIn.ar();

	cfreq = Lag3.kr(cfreq, 0.1);

	mfreq = Lag3.kr(mfreq, 0.1);

	rq   = Ramp.kr(rq, 0.1);

	zout = RLPF.ar(zin, LFNoise1.kr(rate, mfreq, cfreq), rq, 10).distort

					* 0.15;



	// replace the incoming bus with the effected version

	Out.ar([0,1], zout);



}).add;
)



(
var synth1;
synth1 = Synth(\wah);

NetAddr("10.79.9.191",57120);


OSCdef('OSCreceiver',
	{
		arg msg;
		var max = 1400;
		//msg.postln;
		x = msg[1];
		x = x.abs;
		s = LinLin.kr(x, 0, 80, 1000, max);
		//s = round(s, 0.1);


		if(s<0){
		s=0;
		};
		if(s>max){
		s=max;
		};
		s.postln;
		synth1.set(\cfreq,s);

	},
	"/orientation/pitch");
)