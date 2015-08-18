//annie_add_layer(ann_id, number of neurons)
//adds a new layer and creates number of neurons to the ann_id network
//returns number of layers in network
var ann_id, neuron_count;
ann_id = argument0;
neuron_count = argument1;
_ANN_NEURON_COUNT[ann_id,_ANN_LAYER_COUNT[ann_id]] = neuron_count;

//create neurons//
for (j = 0; j < neuron_count; j += 1)
{
    _ANN_NEURON[ann_id + _ANN_LAYER_COUNT[ann_id] * _ANN_COUNT,j] = instance_create(0,0,obj_neuron);
    
    if (_ANN_LAYER_COUNT[ann_id] > 0)
    {
        for (k = 0; k < _ANN_NEURON_COUNT[ann_id,_ANN_LAYER_COUNT[ann_id] - 1]; k += 1)
        {
            //initialize neurons//
            _ANN_NEURON[ann_id + _ANN_LAYER_COUNT[ann_id] * _ANN_COUNT,j].inputCount = _ANN_NEURON_COUNT[ann_id,_ANN_LAYER_COUNT[ann_id] - 1];
            _ANN_NEURON[ann_id + _ANN_LAYER_COUNT[ann_id] * _ANN_COUNT,j].weight[k] = random(0.5);
        }
    }
}

//update previous layers neurons outputCount//
if (_ANN_LAYER_COUNT[ann_id] > 0)
{
    for (j = 0; j < _ANN_NEURON_COUNT[ann_id,_ANN_LAYER_COUNT[ann_id]-1]; j += 1)
    {
        _ANN_NEURON[ann_id + (_ANN_LAYER_COUNT[ann_id] - 1) * _ANN_COUNT,j].outputCount = neuron_count;
    }
}

_ANN_LAYER_COUNT[ann_id] += 1;

return _ANN_NEURON_COUNT[ann_id];
