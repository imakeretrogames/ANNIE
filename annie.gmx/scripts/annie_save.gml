//annie_save(ann_id,filename);
//saves all the network info to a file
var ann_id, str, neuron,file;
ann_id = argument0;
str = "Network " + string(ann_id) + " Info:"+chr(13)+chr(10);
file = 0;

for (i = 0; i < _ANN_LAYER_COUNT[ann_id]; i += 1)
{
    str += chr(13) + chr(10) + "     Layer " + string(i) + ":"+chr(13)+chr(10)

    for (j = 0; j < _ANN_NEURON_COUNT[ann_id,i]; j += 1)
    {//For each neuron in each layer ->
    
        //load neurons//
        neuron[i,j] = _ANN_NEURON[ann_id + i * _ANN_COUNT,j];
        
        if (i == 0)//if checking input layer
        {
            str += "          Neuron " + string(j) + ":"+chr(13)+chr(10);
            str += "               threshold = " + string(neuron[i,j].threshold) + chr(13)+chr(10);
            str += "               weight[0] = " + string(neuron[i,j].weight[0]) + chr(13)+chr(10);
        }
        else//if checking a hidden or output layer
        {
            str += "          Neuron " + string(j) + ":"+chr(13)+chr(10);
            str += "               threshold = " + string(neuron[i,j].threshold) + chr(13)+chr(10);
            for (k = 0; k < _ANN_NEURON_COUNT[ann_id,i-1]; k += 1)
            {
                str += "               weight[" + string(k) + "] = " + string(neuron[i,j].weight[k]) + chr(13)+chr(10);
            }
        }
    }
}

file = file_text_open_write(argument1);
file_text_write_string(file,str);
file_text_close(file);
