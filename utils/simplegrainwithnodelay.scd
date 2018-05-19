ServerOptions.devices

s.options.device_("ASIO : Focusrite USB ASIO");

(

var winenv;

// a custom envelope

winenv = Env([0, 1, 0], [0.5, 0.5], [8, -8]);

z = Buffer.sendCollection(s, winenv.discretize, 1);



SynthDef(\in_grain_test, {arg gate = 1, amp = 1, envbuf;

    var env, grain_rate = MouseX.kr(2, 100); // mouse controls grain rate and duration

    env = EnvGen.kr(

        Env([0, 1, 0], [1, 1], \sin, 1),

        gate,

        levelScale: amp,

        doneAction: 2);

    Out.ar(0, GrainIn.ar(1, Impulse.kr(grain_rate), grain_rate.reciprocal, SoundIn.ar * 0.9, 0, envbuf) * env);

    Out.ar(1, SoundIn.ar * 0.5);

    }).send(s);

)

// use the custom env

x = Synth(\in_grain_test, [\envbuf, z])

x.set(\gate, 0)
