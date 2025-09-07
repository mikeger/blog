mapboxgl.accessToken = 'pk.eyJ1IjoibWlrZWdlciIsImEiOiJjbDJvdGx6cDMxNWt3M2NydTBtczRhczB2In0.pYWcJcW6SyHEQIB68FghAg';

const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v11',
    center: [0, 0],
    zoom: 1
});

map.getCanvas().addEventListener('keydown', (event) => {
    event.stopPropagation();
}, true);

let slides;
let currentSlide = 0;

fetch('presentation.md')
    .then(response => response.text())
    .then(text => {
        slides = text.split('---\n');
        renderSlide(currentSlide);
    });

function renderSlide(slideIndex) {
    const slideContent = slides[slideIndex];
    const mapAttributeMatch = slideContent.match(/<!-- map: (.*) -->/);

    if (mapAttributeMatch) {
                const mapAttributes = {};
                        const attributeRegex = /(\w+)=((?:\[.*?\])|(?:\S+))/g;
        let match;
        while ((match = attributeRegex.exec(mapAttributeMatch[1])) !== null) {
            const key = match[1];
            const value = match[2];
            if (value) {
                mapAttributes[key] = JSON.parse(value);
            }
        }
        if (mapAttributes.center && mapAttributes.zoom) {
            map.flyTo({
                center: mapAttributes.center,
                zoom: mapAttributes.zoom,
                essential: true
            });
        }
    }

    document.getElementById('presentation').innerHTML = marked.parse(slideContent);
}

document.addEventListener('keydown', (event) => {
    if (event.key === 'ArrowRight' && currentSlide < slides.length - 1) {
        currentSlide++;
        renderSlide(currentSlide);
    }
    if (event.key === 'ArrowLeft' && currentSlide > 0) {
        currentSlide--;
        renderSlide(currentSlide);
    }
});
