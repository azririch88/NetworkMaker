#include "networknode.hpp"

void Neuron::loadData(JSON& neuron_j) {

}

void Neuron::saveData(JSON& neuron_j) {
	//cout << "A " << endl;
}

void Neuron::poll() {
    double temp = 0.0;
    for (auto it = input.begin(); it != input.end(); it++)
    {
        temp += ((Synapse*)(*it))->get();
    }
    ((Synapse*)output[0])->set(temp);
}

void Neuron::draw() {

}

void Synapse::loadData(JSON& synapse_j) {
    weight = synapse_j("weight").get<double>();
    val = synapse_j("val").get<double>();
}

void Synapse::saveData(JSON& synapse_j) {
    synapse_j("weight").set(weight);
    synapse_j("val").set(val);
}

void Synapse::set(double value) {
    val = value;
}

double Synapse::get() {
    if (link == 0)
    {
        return val;
    }
    else if (link->from == this)
    {
        link->from->node->poll();
        return val;
    }
    else
    {
        double rtn = ((Synapse*)(link->from))->get();
        return rtn * weight;
    }
}

void Synapse::draw() {
    string str = "Value: ";
    str += to_string(val);
    ImGui::Text(str.c_str());
    if(!linked) {
        ImGui::SameLine();
        if(ImGui::Button("+##val")) {
            val += 0.1;
        }
        ImGui::SameLine();
        if(ImGui::Button("-##val")) {
            val -= 0.1;
        }
    }

    if(input) {
        str = "Weight: ";
        str += to_string(weight);
        ImGui::Text(str.c_str());
        ImGui::SameLine();
        if(ImGui::Button("+##weight")) {
            weight += 0.1;
        }
        ImGui::SameLine();
        if(ImGui::Button("-##weight")) {
            weight -= 0.1;
        }
    }
}
