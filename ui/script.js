const attenuationFactor = 8.0;

var maxVolume = 50;

function updateDistance(distance) {
	var music = document.getElementById('music');

	var volume = ((100 - distance * attenuationFactor) / 100) * (maxVolume / 100);

	if (volume > 0) {
		music.volume = volume;

		if (music.paused) {
			if (music.duration > 0) {
				music.currentTime = Math.floor(Date.now() / 1000) % music.duration;
			}
			music.play();
		}
	} else {
		if (!music.paused) {
			music.pause();
		}
	}
}

window.addEventListener('message', event => {
	switch (event.data.type) {
		case 'updateDistance':
			updateDistance(event.data.distance);
			break;
		case 'setMaxVolume':
			maxVolume = event.data.volume;
			break;
	}
});

window.addEventListener('load', event => {
	fetch(`https://${GetParentResourceName()}/init`)
	.then(resp => resp.json())
	.then(resp => maxVolume = resp);
});
