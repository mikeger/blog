mapboxgl.accessToken = 'pk.eyJ1IjoibWlrZWdlciIsImEiOiJjbDJvdGx6cDMxNWt3M2NydTBtczRhczB2In0.pYWcJcW6SyHEQIB68FghAg'

const map = new mapboxgl.Map({
    container: 'map',
    projection: 'globe',
    style: 'mapbox://styles/mapbox/streets-v11',
    center: [0, 0],
    zoom: 1
})

map.getCanvas().addEventListener('keydown', (event) => {
    if (['ArrowLeft', 'ArrowRight', 'ArrowUp', 'ArrowDown'].includes(event.key)) {
        event.preventDefault()
    }
}, true)

let slides
let currentSlide = -1

fetch('presentation.md')
    .then(response => response.text())
    .then(text => {
        slides = text.split('---\n');
        renderSlide(currentSlide);
    })

map.on('style.load', () => {
  map.setFog({
    color: 'rgb(186, 210, 235)', // Lower atmosphere
    'high-color': 'rgb(36, 92, 223)', // Upper atmosphere
    'horizon-blend': 0.02, // Atmosphere thickness (default 0.2 at low zooms)
    'space-color': 'rgb(11, 11, 25)', // Background color
    'star-intensity': 0.6 // Background star brightness (default 0.35 at low zoooms )
  })
})

map.on('load', () => {
    map.addLayer(
        {
        id: 'country-boundaries',
        source: {
            type: 'vector',
            url: 'mapbox://mapbox.country-boundaries-v1',
        },
        'source-layer': 'country_boundaries',
        type: 'fill',
        paint: {
            'fill-color': 'rgba(102, 80, 172, 1)',
            'fill-opacity': 1,
        },
        },
        'country-label'
    )
    removeHighlight()
})

function renderSlide(slideIndex) {
    if (slideIndex == -1) {
        document.getElementById('cover-container').style.display = 'flex'
    }
    else {
        document.getElementById('cover-container').style.display = 'none'
        const slideContent = slides[slideIndex];
        const mapAttributeMatch = slideContent.match(/<!-- map: (.*) -->/)

        const mapAttributes = {};
        if (mapAttributeMatch) {
            const attributeRegex = /(\w+)=((?:\[.*?\])|(?:\S+))/g
            let match
            while ((match = attributeRegex.exec(mapAttributeMatch[1])) !== null) {
                const key = match[1]
                const value = match[2]
                if (value) {
                    try {
                        mapAttributes[key] = JSON.parse(value)
                    } catch (e) {
                        mapAttributes[key] = value
                    }
                }
            }
        }

        if (mapAttributes.center && mapAttributes.zoom) {
            map.flyTo({
                center: mapAttributes.center,
                zoom: mapAttributes.zoom,
                essential: true
            })
        }

        if (mapAttributes.highlight) {
            highlightCountry(mapAttributes.highlight)

            if (mapAttributes.highlight.length > 3) {
                startGlobeRotation()
            }
        } else {
            removeHighlight()
            stopGlobeRotation()
        }

        const html = marked.parse(slideContent)
        const tempDiv = document.createElement('div')
        tempDiv.innerHTML = html

        const titleElement = tempDiv.querySelector('h1')
        const title = titleElement ? titleElement.outerHTML : ''
        if (titleElement) {
            titleElement.remove()
        }
        const content = tempDiv.innerHTML

        document.getElementById('title-overlay').innerHTML = title
        document.getElementById('content-overlay').innerHTML = content
    }
}

function highlightCountry(countryCodes) {
    const codes = countryCodes.split(',')
    console.log("Filter: ".concat(codes.toString()))
    map.setFilter('country-boundaries', ['in', 'iso_3166_1_alpha_3', ...codes])
}

function removeHighlight() {
    map.setFilter('country-boundaries', ['in', 'iso_3166_1_alpha_3', ''])
}

let rotationInterval

function startGlobeRotation() {
    const secondsPerRevolution = 60
    const maxSpinZoom = 5
    const slowSpinZoom = 3

    function spinGlobe() {
        const zoom = map.getZoom()
        if (zoom < maxSpinZoom) {
            let distancePerSecond = 360 / secondsPerRevolution
            if (zoom < slowSpinZoom) {
                distancePerSecond *= (zoom / slowSpinZoom)
            }
            const center = map.getCenter()
            center.lng -= distancePerSecond
            map.easeTo({ center, duration: 1000, easing: (t) => t, essential: true })
        }
    }

    rotationInterval = setInterval(spinGlobe, 1000)
}

function stopGlobeRotation() {
    if (rotationInterval) {
        clearInterval(rotationInterval);
        rotationInterval = null;
    }
}

document.addEventListener('keydown', (event) => {
    if (event.key === 'ArrowRight' && currentSlide < slides.length - 1) {
        currentSlide++
        renderSlide(currentSlide)
    }
    if (event.key === 'ArrowLeft' && currentSlide > -1) {
        currentSlide--
        renderSlide(currentSlide)
    }
})
