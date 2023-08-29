//synths música cutre

Buffer.read(s, "/home/user/Documents/SuperCollider/20230428 Música cutre/musica_cutre_polifonica.wav");

(
SynthDef(\cutre, {
	arg amp=1;
	var sig;
	sig = PlayBuf.ar(2, 0, doneAction: 2);
	sig = sig * amp;
	Out.ar(0, sig);
}).add;
)

(
SynthDef(\sinus_senzill, {
	arg freq, rel=0.5, amp=1;
	var sig, env;
	env = EnvGen.kr(Env.perc(releaseTime: rel), doneAction: 2);
	sig = SinOsc.ar(freq);
	sig = sig * env;
	sig = Pan2.ar(sig, level: amp);
	Out.ar(0, sig);
}).add;
)

(
SynthDef(\rosa, {
	arg freq, atk=0.01, rel=0.5, amp=0.5;
	var sig, env;
	env = EnvGen.kr(Env.perc(atk, rel), doneAction: 2);
	sig = PinkNoise.ar({amp}!2);
	sig = sig * env;
	Out.ar(0, sig);
}).add;
)

(
SynthDef(\pols, {
	arg freq=100, atk=0.01, rel=0.2, curve= -4, width=0.5, des=0.02, amp=1, pan=0;
	var sig, env;
	env = EnvGen.kr(Env.perc(atk, rel, curve: curve), doneAction: 2);
	sig = Pulse.ar({Rand(freq*(1-des), freq*(1+des))}!19, width);
	sig = sig * env;
	sig = Splay.ar(sig, level: amp, center: pan);
	Out.ar(0, sig);
}).add;
)

(
SynthDef(\vola, {
	arg freq=100, pan=0, amp=0.5;
	var sig, env;
	sig = VarSaw.ar(EnvGen.kr(Env([freq, freq*2], 0.5, \exp), doneAction: 2), width: EnvGen.kr(Env([1, 0, 1], [0.25, 0.25]), doneAction: 2));
	env = EnvGen.kr(Env.perc(0.1, 0.35), doneAction: 2);
	sig = sig * env;
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(0, sig);
}).add;
)

(
SynthDef(\serra, {
	arg freq=500, atk=0.01, rel=0.5, amp=1, pan=0, width=0.1, curve= -4, des=0.02;
	var sig, env;
	env = EnvGen.kr(Env.perc(atk, rel, curve: curve), doneAction: 2);
	sig = VarSaw.ar({Rand(freq*(1-des), freq*(1+des))}!19, width: width);
	sig = sig * env;
	sig = Splay.ar(sig, level: amp, center: pan);
	Out.ar(0, sig);
}).add;
)

(
SynthDef(\sinus, {
	arg freq=100, atk=0.1, rel=0.3, curve= -4, des=0.2, amp=1, pan=0;
	var sig, env;
	env = EnvGen.kr(Env.perc(atk, rel, curve: curve), doneAction: 2);
	sig = SinOsc.ar({ExpRand(freq*2*(1-des), freq*2*(1+des))}!19, {Rand(0, pi)}!19);
	sig = sig * env;
	sig = FreeVerb.ar(sig);
	sig = Splay.ar(sig, level: amp, center: pan);
	Out.ar(0, sig);
}).add;
)


//patterns música cutre

(
Pdef(\musica_cutre,
	Pbind(
		\instrument, \cutre,
		\dur, 8,
		\amp, 0.8
	)
).play(quant: [8, -1.2]);
)

(
Pdef(\baix,
	Pbind(
		\instrument, \sinus_senzill,
		\dur, Pwrand([0.5, 4], [0.99, 0.01], inf),
		\rel, 0.5,
		\midinote, 33,
		\amp, 1
	)
).play(quant: 2);
)

(
Pdef(\txit_2,
	Pbind(
		\instrument, \rosa,
		\dur, Pseq([0.375, 0.375, 0.5, 0.25, 0.125, 0.125, 0.25], inf),
		\atk, 0.015,
		\rel, 0.06,
		\amp, Pwhite(0.1, 0.3)
	)
).play(quant: [2, 0.01]);
)

(
Pdef(\durudara,
	Pbind(
		\instrument, \pols,
		\midinote, Pseq([
			45, 45, 49, 49, 49, 49,
			45, 45, 49, 49, 49, 49,
			49, 49, 48, 48, 48, 48,
			49, 49, 48, 48, 48, 48
		], inf),
		\dur, Pseq([0.125, 0.125, 0.125, 0.5, 0.125, 1], inf),
		\amp, Pwhite(0.05, 0.1),
		\atk, 0.02,
		\rel, 0.1,
		\pan, Pwhite(-1, 1),
		\des, 0.1
	)
).play(quant: [8, -0.265]);
)

(
Pdef(\ocells,
	Pbind(
		\instrument, \vola,
		\midinote, Pseq([105, 104, 103, 102], inf),
		\dur, 0.5,
		\pan, Pwhite(-1, 1),
		\amp, 0.05
	)
).play(quant: 2);
)

(
Pdef(\nironiro,
	Pbind(
		\instrument, \serra,
		\dur, Pseq({0.125}!31 ++ [12.125], inf),
		\midinote, Pseq([
			93, 91,
			92, 90,
			91, 89,
			90, 88,
			89, 87,
			88, 86,
			87, 85,
			86, 84,
			85, 83,
			84, 82,
			83, 81,
			82, 80,
			81, 79,
			80, 78,
			79, 77,
			78, 76
		], inf),
		\des, 0.02,
		\amp, 0.03,
		\width, 0.5,
		\pan, Pwhite(-2, 2)
	)
).play(quant: 16);
)

(
Pdef(\cant,
	Pbind(
		\instrument, \sinus,
		\dur, Pseq([0.25, 0.25, 0.25, 1/3, 1/3, 1/3+2.25], inf),
		\midinote, Pseq([
			52, 52, 52, 45, 47, 49,
			52, 52, 52, 45, 47, 48
		], inf),
		\atk, 0.001,
		\rel, 0.5,
		\des, 0.02,
		\curve, -8,
		\amp, 0.1
	)
).play(quant: [8, 0.25]);
)

(
Pdef(\cant_segona,
	Pbind(
		\instrument, \sinus,
		\dur, Pseq([0.25, 0.25, 0.25, 1/3, 1/3, 1/3+2.25], inf),
		\midinote, Pseq({64}!11 ++ [62], inf),
		\atk, 0.001,
		\rel, 0.5,
		\des, 0.02,
		\curve, -8,
		\amp, 0.02
	)
).play(quant: [8, 0.25]);
)