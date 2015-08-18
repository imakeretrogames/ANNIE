//initializes artificial neural network intelligence engine (ANNIE) 
//global variables for all annie_ scripts to use
globalvar _ANN_COUNT, _ANN_LAYER_COUNT, _ANN_NEURON_COUNT, _ANN_INPUT,
_ANN_NEURON;


_ANN_COUNT = 0;//_ANN_COUNT = number of networks
_ANN_LAYER_COUNT[0] = 0;//_ANN_LAYER_COUNT[ann_id] = number of layers in ann_id network
_ANN_NEURON_COUNT[0,0] = 0;//_ANN_NEURON_COUNT[ann_id,layer] = number of neurons in layer of ann_id network
_ANN_INPUT[0] = -1;//_ANN_INPUT[ann_id] = ds_list
_ANN_NEURON[0,0] = noone;//_ANN_NEURON[ann_id + layer * _ANN_COUNT, neuron number] = instance_id