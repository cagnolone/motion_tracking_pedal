(SynthDef( \distortionlo,
{
	arg amount = 0.99;
	var in, amCoef, sig;
	in = LPF.ar(SoundIn.ar(0), 400)*5;
	amCoef= 2*amount/(1-amount);
	sig = MidEQ.ar(HPF.ar((1+amCoef)*in/(1+(amCoef*in.abs)), [3800, 3900])*0.5, 120, 0.7, 8);
	Out.ar([0,1], sig*0.3);
}).add;
)


(
var synth1;
synth1 = Synth(\distortionlo);

NetAddr("10.79.9.191",57120);


OSCdef('OSCreceiver',
	{
		arg msg;
		var max = 0.99;
		//msg.postln;
		x = msg[1];
		x = x.abs;
		s = LinLin.kr(x, 0, 80, 0, max);
		//s = round(s, 0.1);


		if(s<0){
		s=0;
		};
		if(s>max){
		s=max;
		};
		s.postln;
		synth1.set(\amount,s);

	},
	"/orientation/pitch");
)