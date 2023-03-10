function [color] = rgb_colors(preview)
%% Function containing various RGB-Colors.
% [color] = rgb_colors(preview)
% preview = 'yes'/'no'
%
% manuel.luck@gmail.com
% 
% color.aliceblue               =	[	0.941176471	0.97254902	1	];
% color.antiquewhite            =	[	0.980392157	0.921568627	0.843137255	];
% color.aqua                    =	[	0	1	1	];
% color.aquamarine              =	[	0.498039216	1	0.831372549	];
% color.azure                   =	[	0.941176471	1	1	];
% color.beige                   =	[	0.960784314	0.960784314	0.862745098	];
% color.bisque                  =	[	1	0.894117647	0.768627451	];
% color.black                   =	[	0	0	0	];
% color.blanchedalmond          =	[	1	0.921568627	0.803921569	];
% color.blue                    =	[	0	0	1	];
% color.blueviolet              =	[	0.541176471	0.168627451	0.88627451	];
% color.brown                   =	[	0.647058824	0.164705882	0.164705882	];
% color.burlywood               =	[	0.870588235	0.721568627	0.529411765	];
% color.cadetblue               =	[	0.37254902	0.619607843	0.62745098	];
% color.cadetblue               =	[	0.37254902	0.619607843	0.62745098	];
% color.chartreuse              =	[	0.498039216	1	0	];
% color.chocolate               =	[	0.823529412	0.411764706	0.117647059	];
% color.coral                   =	[	1	0.498039216	0.31372549	];
% color.cornflowerblue          =	[	0.392156863	0.584313725	0.929411765	];
% color.cornsilk                =	[	1	0.97254902	0.862745098	];
% color.crimson                 =	[	0.862745098	0.078431373	0.235294118	];
% color.cyan                    =	[	0	1	1	];
% color.Darkyellow2             =	[	0.6	0.6	0	];
% color.Darkyellow3             =	[	0.4	0.4	0	];
% color.Darkyellow4             =	[	0.2	0.2	0	];
% color.darkblue                =	[	0	0	0.545098039	];
% color.darkcyan                =	[	0	0.545098039	0.545098039	];
% color.darkgray                =	[	0.662745098	0.662745098	0.662745098	];
% color.darkgreen               =	[	0	0.392156863	0	];
% color.darkkhaki               =	[	0.741176471	0.717647059	0.419607843	];
% color.darkmagenta             =	[	0.545098039	0	0.545098039	];
% color.darkolivegreen          =	[	0.333333333	0.419607843	0.184313725	];
% color.darkorange              =	[	1	0.549019608	0	];
% color.darkorchid              =	[	0.6	0.196078431	0.8	];
% color.darkred                 =	[	0.545098039	0	0	];
% color.darksalmon              =	[	0.91372549	0.588235294	0.478431373	];
% color.darkseagreen            =	[	0.560784314	0.737254902	0.560784314	];
% color.darkslateblue           =	[	0.282352941	0.239215686	0.545098039	];
% color.darkslategray           =	[	0.184313725	0.309803922	0.309803922	];
% color.darkturquoise           =	[	0	0.807843137	0.819607843	];
% color.darkviolet              =	[	0.580392157	0	0.82745098	];
% color.deeppink                =	[	1	0.078431373	0.576470588	];
% color.deepskyblue             =	[	0	0.749019608	1	];
% color.dimgray                 =	[	0.411764706	0.411764706	0.411764706	];
% color.dodgerblue              =	[	0.117647059	0.564705882	1	];
% color.firebrick               =	[	0.698039216	0.133333333	0.133333333	];
% color.floralwhite             =	[	1	0.980392157	0.941176471	];
% color.forestgreen             =	[	0.133333333	0.545098039	0.133333333	];
% color.fuchsia                 =	[	1	0	1	];
% color.gainsboro               =	[	0.862745098	0.862745098	0.862745098	];
% color.ghostwhite              =	[	0.97254902	0.97254902	1	];
% color.gold                    =	[	1	0.843137255	0	];
% color.Goldenbrown             =	[	0.6	0.396078431	0.082352941	];
% color.Goldenyellow            =	[	1	0.874509804	0	];
% color.goldenrod               =	[	0.854901961	0.647058824	0.125490196	];
% color.gray                    =	[	0.501960784	0.501960784	0.501960784	];
% color.green                   =	[	0	0.501960784	0	];
% color.greenyellow             =	[	0.678431373	1	0.184313725	];
% color.honeydew                =	[	0.941176471	1	0.941176471	];
% color.hotpink                 =	[	1	0.411764706	0.705882353	];
% color.indianred               =	[	0.803921569	0.360784314	0.360784314	];
% color.indigo                  =	[	0.294117647	0	0.509803922	];
% color.ivory                   =	[	1	1	0.941176471	];
% color.khaki                   =	[	0.941176471	0.901960784	0.549019608	];
% color.lavender                =	[	0.901960784	0.901960784	0.980392157	];
% color.lavenderblush           =	[	1	0.941176471	0.960784314	];
% color.lawngreen               =	[	0.48627451	0.988235294	0	];
% color.Lightyellow1            =	[	1	1	0.8	];
% color.Lightyellow2            =	[	1	1	0.6	];
% color.Lightyellow3            =	[	1	1	0.4	];
% color.lightblue               =	[	0.678431373	0.847058824	0.901960784	];
% color.lightcoral              =	[	0.941176471	0.501960784	0.501960784	];
% color.lightcyan               =	[	0.878431373	1	1	];
% color.lightgoldenrodyellow	=	[	0.980392157	0.980392157	0.823529412	];
% color.lightgray               =	[	0.82745098	0.82745098	0.82745098	];
% color.lightgreen              =	[	0.564705882	0.933333333	0.564705882	];
% color.lightpink               =	[	1	0.71372549	0.756862745	];
% color.lightsalmon             =	[	1	0.62745098	0.478431373	];
% color.lightseagreen           =	[	0.125490196	0.698039216	0.666666667	];
% color.lightskyblue            =	[	0.529411765	0.807843137	0.980392157	];
% color.lightslategray          =	[	0.466666667	0.533333333	0.6	];
% color.lightsteelblue          =	[	0.690196078	0.768627451	0.870588235	];
% color.lime                    =	[	0	1	0	];
% color.limegreen               =	[	0.196078431	0.803921569	0.196078431	];
% color.linen                   =	[	0.980392157	0.941176471	0.901960784	];
% color.magenta                 =	[	1	0	1	];
% color.maroon                  =	[	0.501960784	0	0	];
% color.mediumaquamarine        =	[	0.4	0.803921569	0.666666667	];
% color.mediumblue              =	[	0	0	0.803921569	];
% color.mediumorchid            =	[	0.729411765	0.333333333	0.82745098	];
% color.mediumpurple            =	[	0.576470588	0.439215686	0.858823529	];
% color.mediumseagreen          =	[	0.235294118	0.701960784	0.443137255	];
% color.mediumslateblue         =	[	0.482352941	0.407843137	0.933333333	];
% color.mediumspringgreen       =	[	0	0.980392157	0.603921569	];
% color.mediumturquoise         =	[	0.282352941	0.819607843	0.8	];
% color.mediumvioletred         =	[	0.780392157	0.082352941	0.521568627	];
% color.Metallicgold            =	[	0.831372549	0.68627451	0.215686275	];
% color.midnightblue            =	[	0.098039216	0.098039216	0.439215686	];
% color.mintcream               =	[	0.960784314	1	0.980392157	];
% color.mistyrose               =	[	1	0.894117647	0.882352941	];
% color.moccasin                =	[	1	0.894117647	0.709803922	];
% color.navajowhite             =	[	1	0.870588235	0.678431373	];
% color.navy                    =	[	0	0	0.501960784	];
% color.Oldgold                 =	[	0.811764706	0.709803922	0.231372549	];
% color.oldlace                 =	[	0.992156863	0.960784314	0.901960784	];
% color.olive                   =	[	0.501960784	0.501960784	0	];
% color.olivedrab               =	[	0.419607843	0.556862745	0.137254902	];
% color.orange                  =	[	1	0.647058824	0	];
% color.orangered               =	[	1	0.270588235	0	];
% color.orchid                  =	[	0.854901961	0.439215686	0.839215686	];
% color.Palegold                =	[	0.901960784	0.745098039	0.541176471	];
% color.palegoldenrod           =	[	0.933333333	0.909803922	0.666666667	];
% color.palegreen               =	[	0.596078431	0.984313725	0.596078431	];
% color.paleturquoise           =	[	0.68627451	0.933333333	0.933333333	];
% color.palevioletred           =	[	0.858823529	0.439215686	0.576470588	];
% color.papayawhip              =	[	1	0.937254902	0.835294118	];
% color.peachpuff               =	[	1	0.854901961	0.725490196	];
% color.peru                    =	[	0.803921569	0.521568627	0.247058824	];
% color.pink                    =	[	1	0.752941176	0.796078431	];
% color.plum                    =	[	0.866666667	0.62745098	0.866666667	];
% color.powderblue              =	[	0.690196078	0.878431373	0.901960784	];
% color.purple                  =	[	0.501960784	0	0.501960784	];
% color.red                     =	[	1	0	0	];
% color.rosybrown               =	[	0.737254902	0.560784314	0.560784314	];
% color.royalblue               =	[	0.254901961	0.411764706	0.882352941	];
% color.saddlebrown             =	[	0.545098039	0.270588235	0.074509804	];
% color.salmon                  =	[	0.980392157	0.501960784	0.447058824	];
% color.sandybrown              =	[	0.956862745	0.643137255	0.376470588	];
% color.seagreen                =	[	0.180392157	0.545098039	0.341176471	];
% color.seashell                =	[	1	0.960784314	0.933333333	];
% color.sienna                  =	[	0.62745098	0.321568627	0.176470588	];
% color.silver                  =	[	0.752941176	0.752941176	0.752941176	];
% color.silver                  =	[	0.752941176	0.752941176	0.752941176	];
% color.skyblue                 =	[	0.529411765	0.807843137	0.921568627	];
% color.slateblue               =	[	0.415686275	0.352941176	0.803921569	];
% color.slategray               =	[	0.439215686	0.501960784	0.564705882	];
% color.snow                    =	[	1	0.980392157	0.980392157	];
% color.springgreen             =	[	0	1	0.498039216	];
% color.steelblue               =	[	0.274509804	0.509803922	0.705882353	];
% color.tan                     =	[	0.823529412	0.705882353	0.549019608	];
% color.teal                    =	[	0	0.501960784	0.501960784	];
% color.thistle                 =	[	0.847058824	0.749019608	0.847058824	];
% color.tomato                  =	[	1	0.388235294	0.278431373	];
% color.turquoise               =	[	0.250980392	0.878431373	0.815686275	];
% color.Vegasgold               =	[	0.77254902	0.701960784	0.345098039	];
% color.violet                  =	[	0.933333333	0.509803922	0.933333333	];
% color.wheat                   =	[	0.960784314	0.870588235	0.701960784	];
% color.white                   =	[	1	1	1	];
% color.whitesmoke              =	[	0.960784314	0.960784314	0.960784314	];
% color.yellow                  =	[	1	1	0	];
% color.yellowgreen             =	[	0.603921569	0.803921569	0.196078431	];

%% Colors:
        color.	aliceblue               =	[	0.941176471	0.97254902	1	];
        color.	antiquewhite            =	[	0.980392157	0.921568627	0.843137255	];
        color.	aqua                    =	[	0	1	1	];
        color.	aquamarine              =	[	0.498039216	1	0.831372549	];
        color.	azure                   =	[	0.941176471	1	1	];
        color.	beige                   =	[	0.960784314	0.960784314	0.862745098	];
        color.	bisque                  =	[	1	0.894117647	0.768627451	];
        color.	black                   =	[	0	0	0	];
        color.	blanchedalmond          =	[	1	0.921568627	0.803921569	];
        color.	blue                    =	[	0	0	1	];
        color.	blueviolet              =	[	0.541176471	0.168627451	0.88627451	];
        color.	brown                   =	[	0.647058824	0.164705882	0.164705882	];
        color.	burlywood               =	[	0.870588235	0.721568627	0.529411765	];
        color.	cadetblue               =	[	0.37254902	0.619607843	0.62745098	];
        color.	cadetblue               =	[	0.37254902	0.619607843	0.62745098	];
        color.	chartreuse              =	[	0.498039216	1	0	];
        color.	chocolate               =	[	0.823529412	0.411764706	0.117647059	];
        color.	coral                   =	[	1	0.498039216	0.31372549	];
        color.	cornflowerblue          =	[	0.392156863	0.584313725	0.929411765	];
        color.	cornsilk                =	[	1	0.97254902	0.862745098	];
        color.	crimson                 =	[	0.862745098	0.078431373	0.235294118	];
        color.	cyan                    =	[	0	1	1	];
        color.	Darkyellow2             =	[	0.6	0.6	0	];
        color.	Darkyellow3             =	[	0.4	0.4	0	];
        color.	Darkyellow4             =	[	0.2	0.2	0	];
        color.	darkblue                =	[	0	0	0.545098039	];
        color.	darkcyan                =	[	0	0.545098039	0.545098039	];
        color.	darkgray                =	[	0.662745098	0.662745098	0.662745098	];
        color.	darkgreen               =	[	0	0.392156863	0	];
        color.	darkkhaki               =	[	0.741176471	0.717647059	0.419607843	];
        color.	darkmagenta             =	[	0.545098039	0	0.545098039	];
        color.	darkolivegreen          =	[	0.333333333	0.419607843	0.184313725	];
        color.	darkorange              =	[	1	0.549019608	0	];
        color.	darkorchid              =	[	0.6	0.196078431	0.8	];
        color.	darkred                 =	[	0.545098039	0	0	];
        color.	darksalmon              =	[	0.91372549	0.588235294	0.478431373	];
        color.	darkseagreen            =	[	0.560784314	0.737254902	0.560784314	];
        color.	darkslateblue           =	[	0.282352941	0.239215686	0.545098039	];
        color.	darkslategray           =	[	0.184313725	0.309803922	0.309803922	];
        color.	darkturquoise           =	[	0	0.807843137	0.819607843	];
        color.	darkviolet              =	[	0.580392157	0	0.82745098	];
        color.	deeppink                =	[	1	0.078431373	0.576470588	];
        color.	deepskyblue             =	[	0	0.749019608	1	];
        color.	dimgray                 =	[	0.411764706	0.411764706	0.411764706	];
        color.	dodgerblue              =	[	0.117647059	0.564705882	1	];
        color.	firebrick               =	[	0.698039216	0.133333333	0.133333333	];
        color.	floralwhite             =	[	1	0.980392157	0.941176471	];
        color.	forestgreen             =	[	0.133333333	0.545098039	0.133333333	];
        color.	fuchsia                 =	[	1	0	1	];
        color.	gainsboro               =	[	0.862745098	0.862745098	0.862745098	];
        color.	ghostwhite              =	[	0.97254902	0.97254902	1	];
        color.	gold                    =	[	1	0.843137255	0	];
        color.	Goldenbrown             =	[	0.6	0.396078431	0.082352941	];
        color.	Goldenyellow            =	[	1	0.874509804	0	];
        color.	goldenrod               =	[	0.854901961	0.647058824	0.125490196	];
        color.	gray                    =	[	0.501960784	0.501960784	0.501960784	];
        color.	green                   =	[	0	0.501960784	0	];
        color.	greenyellow             =	[	0.678431373	1	0.184313725	];
        color.	honeydew                =	[	0.941176471	1	0.941176471	];
        color.	hotpink                 =	[	1	0.411764706	0.705882353	];
        color.	indianred               =	[	0.803921569	0.360784314	0.360784314	];
        color.	indigo                  =	[	0.294117647	0	0.509803922	];
        color.	ivory                   =	[	1	1	0.941176471	];
        color.	khaki                   =	[	0.941176471	0.901960784	0.549019608	];
        color.	lavender                =	[	0.901960784	0.901960784	0.980392157	];
        color.	lavenderblush           =	[	1	0.941176471	0.960784314	];
        color.	lawngreen               =	[	0.48627451	0.988235294	0	];
        color.	Lightyellow1            =	[	1	1	0.8	];
        color.	Lightyellow2            =	[	1	1	0.6	];
        color.	Lightyellow3            =	[	1	1	0.4	];
        color.	lightblue               =	[	0.678431373	0.847058824	0.901960784	];
        color.	lightcoral              =	[	0.941176471	0.501960784	0.501960784	];
        color.	lightcyan               =	[	0.878431373	1	1	];
        color.	lightgoldenrodyellow	=	[	0.980392157	0.980392157	0.823529412	];
        color.	lightgray               =	[	0.82745098	0.82745098	0.82745098	];
        color.	lightgreen              =	[	0.564705882	0.933333333	0.564705882	];
        color.	lightpink               =	[	1	0.71372549	0.756862745	];
        color.	lightsalmon             =	[	1	0.62745098	0.478431373	];
        color.	lightseagreen           =	[	0.125490196	0.698039216	0.666666667	];
        color.	lightskyblue            =	[	0.529411765	0.807843137	0.980392157	];
        color.	lightslategray          =	[	0.466666667	0.533333333	0.6	];
        color.	lightsteelblue          =	[	0.690196078	0.768627451	0.870588235	];
        color.	lime                    =	[	0	1	0	];
        color.	limegreen               =	[	0.196078431	0.803921569	0.196078431	];
        color.	linen                   =	[	0.980392157	0.941176471	0.901960784	];
        color.	magenta                 =	[	1	0	1	];
        color.	maroon                  =	[	0.501960784	0	0	];
        color.	mediumaquamarine        =	[	0.4	0.803921569	0.666666667	];
        color.	mediumblue              =	[	0	0	0.803921569	];
        color.	mediumorchid            =	[	0.729411765	0.333333333	0.82745098	];
        color.	mediumpurple            =	[	0.576470588	0.439215686	0.858823529	];
        color.	mediumseagreen          =	[	0.235294118	0.701960784	0.443137255	];
        color.	mediumslateblue         =	[	0.482352941	0.407843137	0.933333333	];
        color.	mediumspringgreen       =	[	0	0.980392157	0.603921569	];
        color.	mediumturquoise         =	[	0.282352941	0.819607843	0.8	];
        color.	mediumvioletred         =	[	0.780392157	0.082352941	0.521568627	];
        color.	Metallicgold            =	[	0.831372549	0.68627451	0.215686275	];
        color.	midnightblue            =	[	0.098039216	0.098039216	0.439215686	];
        color.	mintcream               =	[	0.960784314	1	0.980392157	];
        color.	mistyrose               =	[	1	0.894117647	0.882352941	];
        color.	moccasin                =	[	1	0.894117647	0.709803922	];
        color.	navajowhite             =	[	1	0.870588235	0.678431373	];
        color.	navy                    =	[	0	0	0.501960784	];
        color.	Oldgold                 =	[	0.811764706	0.709803922	0.231372549	];
        color.	oldlace                 =	[	0.992156863	0.960784314	0.901960784	];
        color.	olive                   =	[	0.501960784	0.501960784	0	];
        color.	olivedrab               =	[	0.419607843	0.556862745	0.137254902	];
        color.	orange                  =	[	1	0.647058824	0	];
        color.	orangered               =	[	1	0.270588235	0	];
        color.	orchid                  =	[	0.854901961	0.439215686	0.839215686	];
        color.	Palegold                =	[	0.901960784	0.745098039	0.541176471	];
        color.	palegoldenrod           =	[	0.933333333	0.909803922	0.666666667	];
        color.	palegreen               =	[	0.596078431	0.984313725	0.596078431	];
        color.	paleturquoise           =	[	0.68627451	0.933333333	0.933333333	];
        color.	palevioletred           =	[	0.858823529	0.439215686	0.576470588	];
        color.	papayawhip              =	[	1	0.937254902	0.835294118	];
        color.	peachpuff               =	[	1	0.854901961	0.725490196	];
        color.	peru                    =	[	0.803921569	0.521568627	0.247058824	];
        color.	pink                    =	[	1	0.752941176	0.796078431	];
        color.	plum                    =	[	0.866666667	0.62745098	0.866666667	];
        color.	powderblue              =	[	0.690196078	0.878431373	0.901960784	];
        color.	purple                  =	[	0.501960784	0	0.501960784	];
        color.	red                     =	[	1	0	0	];
        color.	rosybrown               =	[	0.737254902	0.560784314	0.560784314	];
        color.	royalblue               =	[	0.254901961	0.411764706	0.882352941	];
        color.	saddlebrown             =	[	0.545098039	0.270588235	0.074509804	];
        color.	salmon                  =	[	0.980392157	0.501960784	0.447058824	];
        color.	sandybrown              =	[	0.956862745	0.643137255	0.376470588	];
        color.	seagreen                =	[	0.180392157	0.545098039	0.341176471	];
        color.	seashell                =	[	1	0.960784314	0.933333333	];
        color.	sienna                  =	[	0.62745098	0.321568627	0.176470588	];
        color.	silver                  =	[	0.752941176	0.752941176	0.752941176	];
        color.	silver                  =	[	0.752941176	0.752941176	0.752941176	];
        color.	skyblue                 =	[	0.529411765	0.807843137	0.921568627	];
        color.	slateblue               =	[	0.415686275	0.352941176	0.803921569	];
        color.	slategray               =	[	0.439215686	0.501960784	0.564705882	];
        color.	snow                    =	[	1	0.980392157	0.980392157	];
        color.	springgreen             =	[	0	1	0.498039216	];
        color.	steelblue               =	[	0.274509804	0.509803922	0.705882353	];
        color.	tan                     =	[	0.823529412	0.705882353	0.549019608	];
        color.	teal                    =	[	0	0.501960784	0.501960784	];
        color.	thistle                 =	[	0.847058824	0.749019608	0.847058824	];
        color.	tomato                  =	[	1	0.388235294	0.278431373	];
        color.	turquoise               =	[	0.250980392	0.878431373	0.815686275	];
        color.	Vegasgold               =	[	0.77254902	0.701960784	0.345098039	];
        color.	violet                  =	[	0.933333333	0.509803922	0.933333333	];
        color.	wheat                   =	[	0.960784314	0.870588235	0.701960784	];
        color.	white                   =	[	1	1	1	];
        color.	whitesmoke              =	[	0.960784314	0.960784314	0.960784314	];
        color.	yellow                  =	[	1	1	0	];
        color.	yellowgreen             =	[	0.603921569	0.803921569	0.196078431	];

        %
        table = struct2table(color);
        names = table.Properties.VariableNames;
        counter = 1;

        switch preview
                case 'yes'
                        for p = 1 : 2
                                figure('Name','Color Preview','NumberTitle','off','Color','w','Units','normalized','Position',[0.1 0.1 0.8 0.8])
                                for i = 1:10
                                        for j = 1:floor(length(names)/20)
                                                patch([i-1 i-1 i i], [j-1 j j j-1],table{1,counter},'EdgeColor','w');
                                                text(i-0.5,j-0.5,names{1,counter},'HorizontalAlignment','center')
                                                counter = counter + 1;
                                                axis image
                                                axis off
                                                ax=gca;
                                                ax.FontSize=8;
                                                ax.FontName='Calibri Light';
                                                title('Color Preview','Fontsize',12);

                                        end
                                end
                        end
                        clear counter
        end

end



