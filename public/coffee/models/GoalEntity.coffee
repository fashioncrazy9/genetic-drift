define ['cs!models/StaticEntity', 'image!/img/level-asset-goal.png'], (StaticEntity, image) ->

    class GoalEntity extends StaticEntity

        template:
            type: 'static'
            active: true
            image: image.src
            width: 5
            height: 3.3
            imageOffsetX: -1.3
            imageOffsetY: -1

        onTick: =>
            pos = @entity.position()
            offsetX = @template.width / 2
            offsetY = @template.height / 2
            x1 = pos.x - offsetX
            y1 = pos.y - offsetY
            x2 = pos.x + offsetX
            y2 = pos.y + offsetY - .2
            targets = @world.find x1, y1, x2, y2
            return unless targets.length > 1

            # If one of the entities at the goal is the player,
            # trigger the level change event on the canvas
            finished = targets.reduce (x, y) -> x or y._name is 'player'
            if finished then @canvas.trigger('requestLevel')

    return GoalEntity