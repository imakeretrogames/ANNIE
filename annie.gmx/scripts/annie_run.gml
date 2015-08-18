//annie_run(ann_id)
//runs network
//returns ds_list of output if successful else returns -1
var ann_id, sum, list;
ann_id = argument0;
neuron[0,0] = 0;//neuron[ann_id,layer] = instance_id
sum = 0;
list = -1;//ds_list id of network output

for (i = 0; i < _ANN_LAYER_COUNT[ann_id]; i += 1)
{
    for (j = 0; j < _ANN_NEURON_COUNT[ann_id,i]; j += 1)
    {
        //load neurons//
        neuron[i,j] = _ANN_NEURON[ann_id + i * _ANN_COUNT,j];
        
        //run inputs through network//
        if (i == 0) //if checking input layer
        {
            neuron[i,j].input[0] = ds_list_find_value(_ANN_INPUT[ann_id],j) * neuron[i,j].weight[0];
            neuron[i,j].output = neuron[i,j].input[0] > neuron[i,j].threshold;
        }
        else if ((i > 0) && (i < _ANN_LAYER_COUNT[ann_id] - 1))//if checking hidden layers
        {
            sum = 0;
            
            //get neural input and calculate output (sum of each input*weight)
            for (k = 0; k < neuron[i,j].inputCount; k += 1)
            {
                neuron[i,j].input[k] = neuron[i-1,k].output * neuron[i,j].weight[k];
                sum += neuron[i,j].input[k];//sum of each input
            }
            
            //neural output
            neuron[i,j].output = sum > neuron[i,j].threshold;
        }
        else//if checking output layer
        {
            sum = 0;
            
            //get neural input and calculate output (sum of each input*weight)
            for (k = 0; k < neuron[i,j].inputCount; k += 1)
            {
                neuron[i,j].input[k] = neuron[i-1,k].output * neuron[i,j].weight[k];
                sum += neuron[i,j].input[k];//sum of each input
            }
            
            //neural output
            neuron[i,j].output = sum > neuron[i,j].threshold;
            
            if (j == _ANN_NEURON_COUNT[ann_id,i] - 1)//if checking last neuron of the output layer
            {
                list = ds_list_create();
                for (k = 0; k < _ANN_NEURON_COUNT[ann_id,i]; k += 1)
                {   
                    ds_list_add(list,neuron[i,k].output);//add all outputs of output layer neurons to the list
                }
                return list;//return the list of outputs
            }
        }
    }
}
return -1;
