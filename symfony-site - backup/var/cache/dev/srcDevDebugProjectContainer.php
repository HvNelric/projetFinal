<?php

// This file has been auto-generated by the Symfony Dependency Injection Component for internal use.

if (\class_exists(\ContainerX9LEwIx\srcDevDebugProjectContainer::class, false)) {
    // no-op
} elseif (!include __DIR__.'/ContainerX9LEwIx/srcDevDebugProjectContainer.php') {
    touch(__DIR__.'/ContainerX9LEwIx.legacy');

    return;
}

if (!\class_exists(srcDevDebugProjectContainer::class, false)) {
    \class_alias(\ContainerX9LEwIx\srcDevDebugProjectContainer::class, srcDevDebugProjectContainer::class, false);
}

return new \ContainerX9LEwIx\srcDevDebugProjectContainer(array(
    'container.build_hash' => 'X9LEwIx',
    'container.build_id' => 'f13765aa',
    'container.build_time' => 1527107585,
), __DIR__.\DIRECTORY_SEPARATOR.'ContainerX9LEwIx');