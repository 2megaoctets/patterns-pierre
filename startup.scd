// s.options.dump;
// s.addr = NetAddr("169.254.3.159", 57120);


/*
//
This is an example startup file. You can load it from your startup file
(to be found in Platform.userAppSupportDir +/+ "startup.scd")
To be copied and pasted in your SC startup file (in SCIde, do File > Open startup file)
//
*/


(
// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html
s.options.numBuffers = 4096 * 512; // increase this if you need to load more samples
s.options.memSize = 2.pow(20); // increase this if you get "alloc failed" messages
s.options.maxNodes = 1024 * 32; // increase this if you are getting drop outs and the message "too many nodes"
s.options.numOutputBusChannels = 6; // set this to your hardware output channel size, if necessary
s.options.numInputBusChannels = 1; // set this to your hardware output channel size, if necessary
// boot the server and start SuperDirt
s.options.numWireBufs = 64 ** 2;

s.waitForBoot {
	"/home/pi/.local/share/SuperCollider/downloaded-quarks/SuperDirt/hacks/scriptfabien.scd".load;
	~dirt = SuperDirt(2, s); // ?two output channels, increase if you want to pan across more channels
	~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
	// for example: ~dirt.loadSoundFiles("/Users/myUserName/Dirt/samples/*");
	2.wait;
	// s.sync; // optionally: wait for samples to be read
	~dirt.start(57120, [0, 2, 4]);   // start listening on port 57120, create ?two? three busses each sending audio to channel 0
	MIDIClient.init;
	// contrôleur omnitronic fad9 :
	MIDIIn.connect(0,MIDIClient.sources[3]); // connecter à l'entrée MIDI 0, la 4e valeur du tableau retourné par MIDIClient.sources; soit MIDIEndPoint("FAD.9", "FAD.9 MIDI 1")
  // midi output for Carla or whatever you'll seq software / plugins with, here it will be named carla //
	// ~midiOut = MIDIOut.newByName("Midi Through", "Midi Through Port-0").latency_(s.latency);
	// ~dirt.soundLibrary.addMIDI(\midi, ~midiOut);
  // midi hardware output via soundcard, set it up according to your needs below, here it will be named midi //
	// pd
	// ~pdOut = MIDIOut.newByName("Pure Data", "Pure Data Midi-In 1").latency_(s.latency);
	// ~dirt.soundLibrary.addMIDI(\pd, ~pdOut);

  // display more info about loaded samples in SC postwindow (bgold) https://github.com/bgold-cosmos/SuperDirt-extra/blob/master/Tidal5.scd //
	~dirt.postSampleInfo;
};

s.latency = 0.99; // increase this if you get "late" messages
);