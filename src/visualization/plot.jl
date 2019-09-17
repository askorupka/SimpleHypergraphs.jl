#=
plot hypergraphs with different visualizations
layout: color-edge, venn, radal
params: h: Hyperhgraph
        type: color-edge(default), venn, radal
example: plot(h, type="color-edge")
         plot("data.json", type="venn")
=#
idColorEdge=0

function plot(JSONString::String;type="color-edge",colorNodes="#D3D3D3",colorEdges="default",sizeNodes=10)
    Preferences=Dict()
    Preferences["colorNodes"]=colorNodes;
    Preferences["colorEdges"]=colorEdges;
    Preferences["sizeNodes"]=sizeNodes;

    data = conversionJSON(JSONString)

    plotting(data,Preferences,type)
end

function plot(h::Hypergraph;type="color-edge",colorNodes="#D3D3D3",colorEdges="default",sizeNodes=10)
    preferences=Dict()
    preferences["colorNodes"]=colorNodes;
    preferences["colorEdges"]=colorEdges;
    preferences["sizeNodes"]=sizeNodes;

    generateFileJSON(h) #generate a json file into default path

    f = open("data.json","r")
    data = read(f,String)
    close(f)
    plotting(data,preferences,type)

end

function plotting(data,Preferences,type)
    if type=="venn"
        plotVenn(data)
    elseif type=="color-edge"
        global idColorEdge=idColorEdge+1
        plotColorEdge(data,Preferences,idColorEdge)
    elseif type=="radal"
        plotRadal(data)
    end
end
