	// AJAX calls
	// all global variables
	songids = [];
	songnames = [];

	var alblen = songnames.length;
	var idx = 0;
	var cursong = null;


	let current_song = document.getElementById("current-song");
	const play = document.querySelector('.play-pause');
	const seekBar = document.getElementById('seekbar');
	const searchBar = document.getElementById('search-bar');
	const search_results = document.querySelector('#search-res');
	let mute = document.getElementById('mute');
	let volume = document.getElementById('volume');
	let lang = document.getElementById('langs');

	const mobAlbum = document.querySelector(".mob-albums-list");
	const mobRecent = document.querySelector(".mob-recent");
	const closeAlbum = document.getElementById("albums-close");
	const closeRecent = document.getElementById("recent-close");
	const albumsdiv = document.getElementById("albums");
	const recentdiv = document.getElementById("recent");


	$(document).ready(function() {
	    console.log("page loaded");
	    document.getElementById('current-song-album').style.display = "none";
	    $.ajax({
	        url: 'Languages',
	        data: {
	            userName: ''
	        },
	        success: function(responseText) {

	            $('#langs').html(responseText);
	        }
	    });


	    $(document).on("change", "#langs", function() {
	        $.ajax({
	            url: 'Albums',
	            data: {
	                langclicked: $(this).val()
	            },
	            success: function(responseText) {

	                $('#albums').html(responseText);
	            }
	        });

	    });

	    $(document).on("click", "#albumbutton", function(e) {
	        $.ajax({
	            url: 'Songs',
	            data: {
	                album: $(this).val()
	            },
	            success: function(responseText) {
	                $('#songs').html(responseText);
	            }
	        });

	        var urlid = $(this).val();
	        var button = e.target;
	        document.getElementById('current-song-album').innerHTML = button.name;
	        document.getElementById('current-song-album').style.display = "block";

	        var url = document.getElementById(urlid).value;

	        document.getElementById('current-song-img').src = url;

	    });


	    $('#search-bar').on('input', function() {
	        $.ajax({
	            url: 'SearchServlet',
	            data: {
	                searchvalue: $(this).val()
	            },
	            success: function(responseText) {

	                $('#search-res').html(responseText);
	            }
	        });

	    });


	});


	var playpause = () => {
	    updatePlayTime();
	    if (current_song.currentSrc !== "") {
	        let minutes = parseInt(current_song.duration / 60, 10);
	        let seconds = parseInt(current_song.duration % 60);
	        document.getElementById("play-end").innerText = minutes + ':' + seconds;
	        if (current_song.paused) {
	            current_song.play();
	            play.innerHTML = '<i class="fa fa-pause fa-lg" aria-hidden="true"></i>';
	        } else {
	            current_song.pause();
	            play.innerHTML = '<i class="fa fa-play fa-lg" aria-hidden="true"></i>';
	        }
	    }
	}

	// update seek bar
	let updateSeekBar = () => {
	    seekBar.value = current_song.currentTime;
	}



	function playSong(id, name) {
	    document.getElementById('current-song-title').innerText = name;
	    var songurl = document.getElementsByClassName(id)[0].value;
	    document.getElementById('play-song').innerHTML = "<audio controls class='" + name + "' id='current-song'><source src=" + songurl + " type='audio/mpeg'></audio>";
	    current_song = document.getElementById("current-song");
	    current_song.oncanplaythrough = () => {
	        playpause();
	        current_song.ontimeupdate = updatePlayTime;
	        seekBar.max = current_song.duration;

	    }
	    songids.length = 0;
	    songnames.length = 0;
	    var allsongs = document.getElementsByClassName('album-song-name-btn');
	    for (var i = 0; i < allsongs.length; i++) {
	        songids.push(allsongs[i].id);
	        songnames.push(allsongs[i].value);
	    }
	};

	// mute
	let muteUnmute = () => {
	    if (current_song.muted) {
	        mute.innerHTML = '<i class="fa fa-volume-up fa-lg" aria-hidden="true"></i>';
	        current_song.muted = false;
	        //current_song.volume = 1;
	    } else {
	        mute.innerHTML = '<i class="fa fa-volume-off" aria-hidden="true"></i>';
	        current_song.muted = true;
	        //current_song.volume = 0;
	    }
	    updateVolume();
	}

	// update volume 
	let updateVolume = () => {
	    volume.value = current_song.volume;
	}

	// select language 
	let selectLang = () => {
	    if (lang.vale === "") {
	        document.querySelector('.lang-select').classList.add("shake");
	    } else {
	        document.querySelector('.lang-select').classList.remove("shake");
	    }
	}

	// play pause event
	play.addEventListener('click', playpause);

	// at the end of the song		
	current_song.onended = () => {
	        play.innerHTML = '<i class="fa fa-play fa-lg" aria-hidden="true"></i>';
	    }
	    // every time update on song
	let updatePlayTime = () => {
	    let minutes = parseInt(current_song.currentTime / 60, 10);
	    let seconds = parseInt(current_song.currentTime % 60);
	    document.getElementById("play-current").innerText = minutes + ':' + seconds;
	    updateSeekBar();
	}


	seekBar.addEventListener('input', () => {
	    current_song.currentTime = parseInt(seekBar.value);
	    current_song.oncanplay = playpause;
	});


	function playNext() {
	    cursong = document.getElementById("current-song").className;
	    alblen = songnames.length;
	    idx = songnames.indexOf(cursong);

	    if (idx == alblen - 1) {
	        idx = 0;
	        playSong(songids[idx], songnames[idx]);
	    } else {
	        playSong(songids[idx + 1], songnames[idx + 1]);
	    }
	};

	function playPrev() {
	    cursong = document.getElementById("current-song").className;
	    alblen = songnames.length;
	    idx = songnames.indexOf(cursong);

	    if (idx == 0) {
	        idx = alblen - 1;
	        playSong(songids[idx], songnames[idx])
	    } else {
	        playSong(songids[idx - 1], songnames[idx - 1]);
	    }

	}

	// search bar

	// on focus
	searchBar.addEventListener('focus', () => {
	    search_results.style.display = "block";
	});
	// on blur
	searchBar.addEventListener('blur', () => {
	    setTimeout(() => {
	        search_results.style.display = "none";
	        if (searchBar.value.length === 0)
	            search_results.innerHTML = "No results";
	    }, 500);
	});

	// On scroll search results should not be displayed

	window.onscroll = () => {
	    search_results.style.display = "none";
	    if (searchBar.value.length === 0)
	        search_results.innerHTML = "No results";
	    searchBar.blur();
	}


	// mute 

	mute.addEventListener('click', muteUnmute);

	// change volume

	volume.addEventListener('input', () => {
	    current_song.volume = volume.value;
	    updateVolume();
	});

	// if language is selected

	lang.addEventListener('mouseover', () => {
	    document.querySelector('.lang-select').classList.remove("shake");
	});



	// on resizing window


	var resize_mob = () => {
	    let firstRow = document.querySelector('.first-row');
	    let recent = document.querySelector('.recent')
	    if (window.innerWidth < 992) {
	        firstRow.insertBefore(recent, firstRow.firstElementChild.nextSibling);
	        document.querySelector('.albums-list').style.display = "none";
	        document.querySelector('.recent').style.display = "none";
	        mobAlbum.style.display = "block";
	        mobRecent.style.display = "block";

	    } else {
	        recent.remove();
	        firstRow.appendChild(recent);
	        document.querySelector('.albums-list').style.display = "block";
	        document.querySelector('.recent').style.display = "block";
	        mobAlbum.style.display = "none";
	        mobRecent.style.display = "none";
	    }
	};

	resize_mob();
	window.addEventListener('resize', resize_mob);

	// on click of albums btn

	// gloabal objects added above for this 

	mobAlbum.addEventListener('click', () => {
	    mobAlbum.style.display = "none";
	    mobRecent.style.display = "none";
	    document.querySelector('.albums-list').style.display = "block";

	})

	closeAlbum.addEventListener('click', () => {
	    mobAlbum.style.display = "block";
	    mobRecent.style.display = "block";
	    document.querySelector('.albums-list').style.display = "none";
	})
	mobRecent.addEventListener('click', () => {
	    mobAlbum.style.display = "none";
	    mobRecent.style.display = "none";
	    document.querySelector('.recent').style.display = "block";

	})

	closeRecent.addEventListener('click', () => {
	    mobAlbum.style.display = "block";
	    mobRecent.style.display = "block";
	    document.querySelector('.recent').style.display = "none";
	})


	// added after sending file on 26th july added 2 variables above 
	// albumdiv and recentdiv

	albumsdiv.addEventListener('click', (event) => {
	    const isbutton = event.target.nodeName === "BUTTON";
	    if (isbutton && window.innerWidth < 992) {
	        mobAlbum.style.display = "block";
	        mobRecent.style.display = "block";
	        document.querySelector('.albums-list').style.display = "none";
	    }
	});

	recentdiv.addEventListener('click', (event) => {
	    const isbutton = event.target.nodeName === "BUTTON";
	    if (isbutton && window.innerWidth < 992) {
	        mobAlbum.style.display = "block";
	        mobRecent.style.display = "block";
	        document.querySelector('.recent').style.display = "none";
	    }
	})