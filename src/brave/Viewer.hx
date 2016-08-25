package brave;

import js.Browser.document;
import js.Browser.window;

/**
	0: signal,
	1: attention,

	2: meditation,
	3: delta,

	4: theta,
	5: low alpha,
	6: high alpha,
	7: low beta,
	8: high beta,
	9: low gamma,
	10: high gamma
*/
class Viewer {

	static var COLORS = [

		'#030200',
		'#2F3A3E',

		'#014B92',
		'#E85811',

		'#E52E88',
		'#036D56',
		'#aaaaaa',
		'#01822F',
		'#7BB11D',
		'#AD0B1A',
		'#CA041B',
		'#6C2D7E',
		'#8C4A91'
	];

	static function draw( dump : String ) {

		var data = [for(i in 0...11)[]];

		var lines = dump.split( '\n' );
		lines.pop();
		for( i in 0...lines.length ) {
			var values = lines[i].split( ',' );
			for( j  in 0...11 ) {
				data[j].push( Std.parseInt( values[j] ) );
			}
		}

		var maxValues = [for(i in 0...data.length) 0 ];
		for( i in 0...data.length ) {
			for( j in 0...data[i].length ) {
				var v = data[i][j];
				if( v > maxValues[i] ) maxValues[i] = v;
			}
		}

		var canvas = document.createCanvasElement();
		canvas.width = window.innerWidth;
		canvas.height = window.innerHeight;
		document.body.appendChild( canvas );

		var ctx = canvas.getContext2d();
		ctx.lineWidth = 1;

		var timeStart = data[0][0];
		var timeEnd = data[0][data[0].length-1];
		var timeTotal = timeEnd - timeStart;
		//trace(timeTotal);

		var sw = canvas.width / data[0].length;

		//for( i in 0...data.length ) {
		for( i in 2...4 ) {

			var values = data[i];

			ctx.strokeStyle = COLORS[i];
			ctx.beginPath();
			ctx.moveTo(0,0);
			for( j in 0...values.length ) {
				var v = values[j];
				ctx.lineTo( j*sw, v );
			}
			//ctx.closePath();
			ctx.stroke();
		}
	}

	static function main() {
		window.onload = function() {
			var dumpFile = '../brain.dump';
			var http = new haxe.Http( dumpFile );
			http.onData = function(dump) {
				draw( dump );
			}
			http.request();
		}
	}
}
