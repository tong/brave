package brave;

import js.Browser.document;
import js.Browser.window;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;

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

	static var canvas : CanvasElement;
	static var ctx : CanvasRenderingContext2D;

	static function loadData( path : String, callback : String->String->Void ) {
		var http = new haxe.Http( path );
		http.onData = function(dump) {
			callback( null, dump );
		}
		http.onError = function(error) {
			callback( error, null );
		}
		http.request();
	}

	static function parseData( dump : String ) : Array<Array<Int>> {

		var data = [for(i in 0...11)[]];

		var lines = dump.split( '\n' );
		lines.pop();
		for( i in 0...lines.length ) {
			var values = lines[i].split( ',' );
			for( j  in 0...11 ) {
				data[j].push( Std.parseInt( values[j] ) );
			}
		}

		/*
		var maxValues = [for(i in 0...data.length) 0 ];
		for( i in 0...data.length ) {
			for( j in 0...data[i].length ) {
				var v = data[i][j];
				if( v > maxValues[i] ) maxValues[i] = v;
			}
		}
		*/

		return data;
	}

	static function drawWave( data : Array<Int>, color : String ) {
		var sw = canvas.width / data.length;
		ctx.strokeStyle = color;
		ctx.beginPath();
		ctx.moveTo(0,0);
		for( i in 0...data.length ) {
			ctx.lineTo( i*sw, data[i] );
		}
		//ctx.closePath();
		ctx.stroke();
	}

	static function main() {

		window.onload = function() {

			canvas = document.createCanvasElement();
			canvas.width = window.innerWidth;
			canvas.height = window.innerHeight;
			document.body.appendChild( canvas );

			ctx = canvas.getContext2d();
			ctx.lineWidth = 1;

			var file = '../brain.dump';
			loadData( file, function(e,dump){
				if( e != null ) trace(e) else {
					var data = parseData( dump );
					//for( i in 0...data.length ) {
					for( i in 2...4 ) {
						var v = data[i];
						drawWave( v, COLORS[i] );
					}
				}
			});
		}
	}

}
