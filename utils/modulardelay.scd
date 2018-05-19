

s.options.device_("ASIO : Focusrite USB ASIO");

(

SynthDef(\delaynointerpolation, {
     // first input
    // delay output to tame feedback in case of microphones are configured:
	var effect= DelayN.ar(SoundIn.ar , 10 , MouseX.kr);
    Out.ar(0, effect + SoundIn.ar*0.4);
	Out.ar(1, effect + SoundIn.ar*0.4);
}).play
)


(

SynthDef(\delaynointerpolation, {
     // first input
    // delay output to tame feedback in case of microphones are configured:
	arg delaytime = 0;
	var effect= DelayN.ar(SoundIn.ar , 10 , delaytime);
    Out.ar(0, effect + SoundIn.ar*0.4);
	Out.ar(1, effect + SoundIn.ar*0.4);
}).add
)

s = Synth(\pitchshift);


NetAddr("10.79.9.191",57120);



(
var synth1;
synth1 = Synth(\delaynointerpolation);


OSCdef('OSCreceiver',
	{
		arg msg;
		var max = 2;
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
		synth1.set(\delaytime,s);

	},
	"/orientation/pitch");
)