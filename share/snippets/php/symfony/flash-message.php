<?php

$this->get(‘session’)->getFlashBag()->add(‘notice’, ‘Your changes were saved!’);

$twig = <<<HERETWIG
{% for flashMessage in app.session.flashbag.get(‘notice’) %}

{{ flashMessage }}

{% endfor %}
HERETWIG;
