define ['cs!models/Character'], (Character) ->

    class PlayableCharacter extends Character

        planted: false

        onKeydown: (e) =>

            @speed = @entity._body.m_linearVelocity.x

            console.log 'e.keyCode', e.keyCode if console.log?

            if e.keyCode is 32 # and standingOn.length
                @entity.applyImpulse 20, 0, -1
                @setAction (if @speed > 0 or @currentAction.indexOf('Right') isnt -1 then 'jumpRight' else 'jumpLeft')
                return false
            
            if e.keyCode is 37 # or e.keyCode is 65
                @entity.friction 0
                @entity.setForce 'movement', 8, 270
                if @currentAction.indexOf('jump') is -1 then @setAction 'runLeft'
                return false

            if e.keyCode is 39 # or e.keyCode is 68
                @entity.friction 0
                @entity.setForce 'movement', 8, 90
                if @currentAction.indexOf('jump') is -1 then @setAction 'runRight'
                return false

            if e.keyCode is 67 
                pos = @entity.position()
                clone = new Character @world,
                    x: pos.x
                    y: pos.y
                clone.register()
                return false

            if e.keyCode is 86
                @setAction (if @speed > 0 or @currentAction.indexOf('Right') isnt -1 then 'attackRight' else 'attackLeft')
                return false

        onKeyup: (e) =>

            if e.keyCode is 37 or e.keyCode is 39
                @entity.clearForce 'movement'
                @entity.friction 3
                return false

    return PlayableCharacter