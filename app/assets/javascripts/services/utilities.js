angular.module('liveClinic')
    .factory('Utilities', [
        '$http', 'Upload',
        function($http, Upload){
        	var utilities = {}

        	AWS.config.credentials = {
				accessKeyId: "AKIAIM4MLRSWVVW45QPQ",
				secretAccessKey: "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"
			};

			AWS.config.region = 'us-west-2';

        	utilities.upload = function ( file, path, fnSuccess, fnError ) {
        		if ( ! file ) return;

				var bucket = new AWS.S3({params: {Bucket: 'liveclinic'}});

				var filename = Date.now().toString(16) + Math.floor((Math.random() * 16)).toString(16);
				var subpath = moment().format('YYYYMM');
				var ext = file.name.split( "." ).pop();

				var params = { Key: path + "/" + subpath + "/" + filename + "." + ext, ContentType: file.type, Body: file, ACL: 'public-read' };

				// console.log( path + "/" + subpath + "/" + filename + "." + ext );

				bucket.upload(params, function (err, data) {
					if ( err ) {
						fnError( err );
					} else { 
						fnSuccess( data );
					}
				});
        	};

        	utilities.uploadCarrierWave = function(url, data, fnSuccess, fnError) {
        		Upload.upload({
					url: url,
					data: data
				}).then(function (resp) {
					if (fnSuccess) fnSuccess(resp);
				}, function (err) {
					if (fnError) fnError(err);
				});
        	}

            // ----- fax -----
        	utilities.faxInbox = function() {
        		return $http.get('/api/thirdparty/view-fax-inbox')
        	}

        	utilities.faxSent = function() {
        		return $http.get('/api/thirdparty/view-fax-sent')
        	}

        	utilities.sendFax = function( data, fnSuccess, fnError ) {
        		utilities.uploadCarrierWave( '/api/thirdparty/send-fax-sent', data, fnSuccess, fnError );
        	}

        	utilities.readFaxInbox = function(id) {
        		return $http.post('/api/thirdparty/read-fax-inbox/', { id: id })
        	}

        	utilities.deleteFaxInbox = function(id) {
        		return $http.delete('/api/thirdparty/fax-inbox/' + id )
        	}

        	utilities.deleteFaxSent = function(id) {
        		return $http.delete('/api/thirdparty/fax-sent/' + id )
        	}

            // ----- mail -----
            utilities.mailInbox = function(type) {
                return $http.get('/api/thirdparty/view-mail-inbox/' + type)
            }

            utilities.mailSent = function(type) {
                return $http.get('/api/thirdparty/view-mail-sent/' + type)
            }

            utilities.sendMail = function(data, fnSuccess, fnError) {
                utilities.uploadCarrierWave( '/api/thirdparty/send-mail-sent', data, fnSuccess, fnError );

            }

            utilities.readMailInbox = function(id) {
            	return $http.post('/api/thirdparty/read-mail-inbox/', { id: id })
            }

            utilities.deleteMailInbox = function(id) {
                return $http.delete('/api/thirdparty/mail-inbox/' + id )
            }

            utilities.deleteMailSent = function(id) {
                return $http.delete('/api/thirdparty/mail-sent/' + id )
            }
        	return utilities;
        }
	])