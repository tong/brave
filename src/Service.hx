
import js.node.Buffer;
import js.npm.SerialPort;

class Service {

	static function main() {

		SerialPort.list(function(e,devices) {

			if( e != null ) trace(e) else {

				//for( device in devices ) trace( device );

				var port = devices[0];
				var serial = new SerialPort( port.comName, {
					baudrate: _9600
				});
				serial.on( 'open', function(){
					Sys.println( 'Brain connected.' );
				});

				var input = '';
				serial.on( 'data', function(buf){
					var str = buf.toString();
					var lineBreakPos = str.indexOf( '\n' );
					if( lineBreakPos != -1 ) {
						input += str.substr( 0, lineBreakPos );
						var line = Date.now().getTime()+','+input;
						Sys.println( line );
						js.node.Fs.appendFile( 'brain.dump', line+'\n', function(e){} );
						input = str.substring( lineBreakPos+1 );

					} else {
						input += str;
						//Sys.print( '*' );
					}
				});
			}
		});
	}
}
