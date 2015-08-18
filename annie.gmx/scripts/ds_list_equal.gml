//ds_list_equal(list1,list2)
//returns true if both lists are equal else false
var list1, list2;
list1 = argument0;
list2 = argument1;
if (ds_list_size(list1) == ds_list_size(list2))
{
    for (i = 0; i < ds_list_size(list1); i += 1)
    {
        if (ds_list_find_value(list1,i) != ds_list_find_value(list2,i))
        {
            return false;
        }
    }
    
    return true;
}
else
{
    return false;
}
