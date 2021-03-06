const maxVolume = 50;
const attenuationFactor = 8.0;

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
	}
});
