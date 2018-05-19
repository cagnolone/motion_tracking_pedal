(

SynthDef(\idk, {
	var a, d, s;

	a = SoundIn.ar;

	// the "distortion modeling" could use some more love...
	s = (a * MouseY.kr(26/2, 0).dbamp).tanh;
	s = s * MouseY.kr(-16/2, 0).dbamp;

	// a simple delay
	d = DelayC.ar(s, 0.1, MouseX.kr(3.5/1000, 65/1000));

	// dry/wet...
	a = a + (d * MouseY.kr(0, -96).dbamp);

	Out.ar(0, a);
	Out.ar(1, a);
}).play
)