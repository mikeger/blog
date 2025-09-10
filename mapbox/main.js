mapboxgl.accessToken = 'pk.eyJ1IjoibWlrZWdlciIsImEiOiJjbDJvdGx6cDMxNWt3M2NydTBtczRhczB2In0.pYWcJcW6SyHEQIB68FghAg'

const contentSlideOverlay = document.createElement('div');
contentSlideOverlay.id = 'content-slide-overlay';
contentSlideOverlay.style.cssText = `
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: white;
    color: black;
    z-index: 2;
    display: none;
    overflow-y: auto;
    padding: 40px 5%;
    box-sizing: border-box;
`;
document.body.appendChild(contentSlideOverlay);

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
let currentSlide = 0


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

    fetch('presentation.md')
    .then(response => response.text())
    .then(text => {
        slides = text.split('---')
        renderSlide(currentSlide)
    })
})

function renderSlide(slideIndex) {
    const titleOverlay = document.getElementById('title-overlay');
    const contentOverlay = document.getElementById('content-overlay');
    const coverContainer = document.getElementById('cover-container');

    const slideContent = slides[slideIndex];
    const mapAttributeMatch = slideContent.match(/<!-- map: (.*) -->/);

    if (mapAttributeMatch) {
        // MAP SLIDE
        titleOverlay.style.display = 'block';
        contentOverlay.style.display = 'block';
        coverContainer.style.display = 'none';

        const mapAttributes = {};
        const attributeRegex = /(\w+)=((?:\[.*?\])|(?:\S+))/g;
        let match;
        while ((match = attributeRegex.exec(mapAttributeMatch[1])) !== null) {
            const key = match[1];
            const value = match[2];
            if (value) {
                try {
                    mapAttributes[key] = JSON.parse(value);
                } catch (e) {
                    mapAttributes[key] = value;
                }
            }
        }

        if (mapAttributes.center && mapAttributes.zoom) {
            console.log(mapAttributes)
            console.log(mapAttributes.center)
            map.flyTo({
                center: mapAttributes.center,
                zoom: mapAttributes.zoom,
                essential: true
            });
        }

        if (mapAttributes.highlight) {
            highlightCountry(mapAttributes.highlight);

            if (mapAttributes.highlight.length > 3) {
                startGlobeRotation();
            }
        } else {
            removeHighlight();
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

        titleOverlay.innerHTML = title
        contentOverlay.innerHTML = parseImage(tempDiv)

    } else {
        // CONTENT SLIDE
        removeHighlight()
        stopGlobeRotation()

        titleOverlay.style.display = 'none'
        contentOverlay.style.display = 'none'
        coverContainer.style.display = 'block'

        const html = marked.parse(slideContent)

        const tempDiv = document.createElement('div')
        tempDiv.innerHTML = html

        coverContainer.innerHTML = parseImage(tempDiv)
    }
}

function parseImage(tempDiv) {
    let imageParagraph = null
    let imageWidth
    let alignment
    const images = Array.from(tempDiv.querySelectorAll('img'))

    for (const img of images) {
        const alt = img.getAttribute('alt') || '';
        const match = alt.match(/bg right:(\d+)%/);
        if (match) {
            const p = img.parentElement;
            if (p.tagName === 'P') {
                imageParagraph = p;
                if (match[1]) {
                    imageWidth = `${match[1]}%`
                }
                break;
            }
        }
        else {
            const match = alt.match(/width:(\d+)%/);
            if (match) {
                const p = img.parentElement;
                if (p.tagName === 'P') {
                    imageParagraph = p;
                    alignment = 'left'
                    if (match[1]) {
                        imageWidth = `${match[1]}%`
                    }
                }
            }
            
            const matchCenter = alt.match(/center/);
            if (matchCenter) {
                const p = img.parentElement;
                if (p.tagName === 'P') {
                    imageParagraph = p;
                    alignment = 'center'
                }
            }
        }
    }
    let content
    if (imageParagraph) {
        if (alignment) {
            imageParagraph.style.textAlign = alignment
            console.log(alignment)
            if (imageWidth) {
                const img = imageParagraph.querySelector('img')
                if (img) {
                    img.style.width = imageWidth
                }
            }
            content = tempDiv.innerHTML
        }
        else {
            const flexContainer = document.createElement('div')
            flexContainer.style.display = 'flex'
            flexContainer.style.alignItems = 'flex-start'
            flexContainer.style.height = '100%'
            flexContainer.style.boxSizing = 'border-box'

            const mainContent = document.createElement('div')
            mainContent.style.flex = '1'

            const otherNodes = Array.from(tempDiv.childNodes).filter(node => node !== imageParagraph)
            otherNodes.forEach(node => mainContent.appendChild(node))

            flexContainer.appendChild(mainContent)
            flexContainer.appendChild(imageParagraph)

            imageParagraph.style.width = imageWidth
            imageParagraph.style.marginLeft = '20px'
            imageParagraph.style.marginRight = '40px'
            imageParagraph.style.marginBottom = '0px'
            imageParagraph.style.height = '100%'

            imageParagraph.style.display = 'flex';
            imageParagraph.style.flexDirection = 'column';
            imageParagraph.style.justifyContent = 'center'; // vertical center

            imageParagraph.style.flexShrink = '0'

            const img = imageParagraph.querySelector('img')
            if (img) {
                img.style.width = '100%'
                img.style.height = 'auto'
            }

            content = flexContainer.outerHTML
        }
    } else {
        content = tempDiv.innerHTML
    }

    return content
}

function highlightCountry(countryCodes) {
    const codes = countryCodes.split(',')
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
        clearInterval(rotationInterval)
        rotationInterval = null
    }
}

function nextSlide() {
    if (currentSlide < slides.length - 1) {
        currentSlide++
        renderSlide(currentSlide)
    }
}

document.addEventListener('keydown', (event) => {
    if (event.key === 'ArrowRight' || event.key === ' ' || event.code === 'Space') {
        nextSlide()
    }
    if (event.key === 'ArrowLeft' && currentSlide > 0) {
        currentSlide--
        renderSlide(currentSlide)
    }
})
